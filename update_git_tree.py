from json import dumps, load
from subprocess import run

# Update CLibNG git-tree
clib_git_tree = run(
    ["git", "rev-parse", "HEAD:ports/commonlibsse-ng"], capture_output=True
).stdout.decode()

with open("./versions/c-/commonlibsse-ng.json") as f:
    version = load(f)

version["versions"][0]["git-tree"] = clib_git_tree.strip("\n")

version_str = dumps(version, indent=2)
version_str += "\r\n"

with open("./versions/c-/commonlibsse-ng.json", "w", newline="\r\n") as f:
    f.write(version_str)
