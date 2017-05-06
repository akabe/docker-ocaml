(** Generator of Dockerfile
 *
 * This program generates Dockerfile(s) into each git-branches by
 *
 * $ ocaml dockerfile.ml
 *)

#use "topfind";;
#require "lwt";;
#require "lwt.ppx";;
#require "git-unix";;

open Lwt.Infix
open Format

module GitUtil = struct
  open Git_unix

  let first_commit =
    Hash_IO.of_hex "41db134a4cc2a43c75746288848220ea09fe2194"

  let create_branch git branch =
    FS.read_reference git branch >>= function
    | Some head -> Lwt.return_unit
    | None -> FS.write_reference git branch first_commit

  let rec read_tree_exn git head =
    FS.read_exn git head >>= function
    | Git.Value.Tree t -> Lwt.return t
    | Git.Value.Commit c -> read_tree_exn git (Git.Hash.of_tree c.Git.Commit.tree)
    | _ -> failwith "Not a commit or tree hash"

  let create_file git filename contents =
    FS.write git (Git.Value.blob (Git.Blob.of_raw contents)) >|= fun node ->
    Git.Tree.({ perm = `Normal; name = filename; node; })

  let create_tree ?(branch = Git.Reference.head) git files =
    let put_file (name, contents) = create_file git name contents in
    let add_to_tree tree entry =
      let open Git.Tree in
      entry :: List.filter (fun e -> e.name <> entry.name) tree
    in
    let%lwt entries = Lwt_list.map_p put_file files in
    let%lwt head = FS.read_reference_exn git branch in
    let%lwt tree = read_tree_exn git head in
    let tree' = List.fold_left add_to_tree tree entries in
    if tree = tree' then Lwt.return_none
    else FS.write git (Git.Value.tree tree') >|= fun hash -> Some hash

  let commit_tree
        ?(branch = Git.Reference.head) ?(message = "No commit message")
        ?(name = "") ?(email = "no-reply@example.com")
        git tree =
    let timestamp = Unix.time () |> Int64.of_float in
    let user = Git.User.({ name; email; date = (timestamp, None); }) in
    let%lwt head = FS.read_reference_exn git branch in
    let commit = Git.Commit.({ tree = Git.Hash.to_tree tree;
                               parents = [Git.Hash.to_commit head];
                               author = user; committer = user; message; }) in
    let%lwt hash = FS.write git (Git.Value.commit commit) in
    let%lwt () = FS.write_index git (Git.Hash.to_commit hash) in
    let%lwt () = FS.write_reference git branch hash in
    Lwt.return hash
end

(** Commands executed in Docker *)
module Script = struct
  let pp =
    pp_print_list
      ~pp_sep:(fun ppf () -> fprintf ppf " && \\@\n    ")
      pp_print_string

  let alpine = [
      "apk update";
      "apk upgrade";
      "apk add --upgrade --no-cache alpine-sdk libx11-dev";
      "mkdir /lib64";
      "ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2";
      "adduser -h $HOME -s /bin/sh -D opam";
    ]

  let opam = [
      "echo 'opam ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers";
      "curl -s -L -o /usr/bin/opam \"https://github.com/ocaml/opam/releases/download/$OPAM_VERSION/opam-$OPAM_VERSION-$(uname -m)-$(uname -s)\"";
      "chmod 755 /usr/bin/opam";
      "su opam -c \"opam init -a -y --comp $OCAML_VERSION\"";
    ]

  let cleanup = [
      "rm $HOME/.profile $HOME/.opam/opam-init/init.*";
      "find $HOME/.opam -regex '.*\\.\\(cmt\\|cmti\\|annot\\|byte\\)' -delete";
      "rm -rf $HOME/.opam/archives \
              $HOME/.opam/repo/default/archives \
              $HOME/.opam/$OCAML_VERSION/build";
    ]
end

module Dockerfile = struct
  type t =
    {
      tag : string;
      from : string;
      opam_version : string;
      ocaml_version : string;
      script : string list;
    }

  let write_file filename str =
    let oc = open_out filename in
    output_string oc str;
    close_out oc

  let to_string df =
    asprintf "FROM %s@\n\
              @\n\
              ENV OPAM_VERSION  %s@\n\
              ENV OCAML_VERSION %s@\n\
              ENV HOME          /home/opam@\n\
              @\n\
              RUN %a@\n\
              @\n\
              USER opam@\n\
              WORKDIR $HOME@\n\
              @\n\
              ENTRYPOINT [ \"opam\", \"config\", \"exec\", \"--\" ]@\n\
              CMD [ \"sh\" ]@."
             df.from df.opam_version df.ocaml_version
             Script.pp df.script
end

let dockerfiles =
  let open Dockerfile in
  [
    {
      tag = "latest";
      from = "alpine:3.5";
      opam_version = "1.2.2";
      ocaml_version = "4.04.1";
      script = Script.(alpine @ opam @ cleanup);
    };
    {
      tag = "alpine3.5_ocaml4.06.0";
      from = "alpine:3.5";
      opam_version = "1.2.2";
      ocaml_version = "4.06.0+trunk";
      script = Script.(alpine @ opam @ cleanup);
    };
    {
      tag = "alpine3.5_ocaml4.05.0";
      from = "alpine:3.5";
      opam_version = "1.2.2";
      ocaml_version = "4.05.0+trunk";
      script = Script.(alpine @ opam @ cleanup);
    };
    {
      tag = "alpine3.5_ocaml4.04.1";
      from = "alpine:3.5";
      opam_version = "1.2.2";
      ocaml_version = "4.04.1";
      script = Script.(alpine @ opam @ cleanup);
    };
    {
      tag = "alpine3.5_ocaml4.03.0";
      from = "alpine:3.5";
      opam_version = "1.2.2";
      ocaml_version = "4.03.0";
      script = Script.(alpine @ opam @ cleanup);
    };
    {
      tag = "alpine3.5_ocaml4.02.3";
      from = "alpine:3.5";
      opam_version = "1.2.2";
      ocaml_version = "4.02.3";
      script = Script.(alpine @ opam @ cleanup);
    };
    {
      tag = "alpine3.5_ocaml4.01.0";
      from = "alpine:3.5";
      opam_version = "1.2.2";
      ocaml_version = "4.01.0";
      script = Script.(alpine @ opam @ cleanup);
    };
    {
      tag = "alpine3.5_ocaml4.00.1";
      from = "alpine:3.5";
      opam_version = "1.2.2";
      ocaml_version = "4.00.1";
      script = Script.(alpine @ opam @ cleanup);
    };
  ]

open Git_unix

let commit ~branch git df = function
  | None ->
     printf "%s: unchanged@." df.Dockerfile.tag;
     Lwt.return_unit
  | Some tree ->
     let%lwt commit =
       GitUtil.commit_tree
         ~branch ~message:"updated Dockerfile"
         ~name:"Akinori ABE" ~email:"aabe.65535@gmail.com"
         git tree in
     printf "%s: updated (commit %a)@." df.Dockerfile.tag Git.Hash.pp commit;
     Lwt.return_unit

let push tag =
  let cmd = sprintf "git push origin release/%s" tag in
  assert(Sys.command cmd = 0);
  Lwt.return_unit

let generate git df =
  let module Result = Sync.Result in
  let module Sync = Sync.Make(Git_unix.FS) in
  let contents = Dockerfile.to_string df in
  let branch = sprintf "refs/heads/release/%s" df.Dockerfile.tag
               |> Git.Reference.of_raw in
  let%lwt () = GitUtil.create_branch git branch in
  let%lwt tree_opt = GitUtil.create_tree ~branch git ["Dockerfile", contents] in
  let%lwt () = commit ~branch git df tree_opt in
  push df.Dockerfile.tag

let main () =
  let%lwt git = FS.create ~root:(Sys.getcwd ()) () in
  Lwt_list.iter_s (generate git) dockerfiles

let () = Lwt_main.run (main ())
