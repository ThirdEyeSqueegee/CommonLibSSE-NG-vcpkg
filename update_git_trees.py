from json import dump, load
from subprocess import run

# Update CLibNG git-tree
clib_git_tree = run(
    ["git", "rev-parse", "HEAD:ports/commonlibsse-ng"], capture_output=True
).stdout.decode()

with open("./versions/c-/commonlibsse-ng.json", "r") as f:
    version = load(f)

version["versions"][0]["git-tree"] = clib_git_tree.strip("\n")

with open("./versions/c-/commonlibsse-ng.json", "w") as f:
    dump(version, f, indent=2)

# Update spdlog git-tree
spdlog_git_tree = run(
    ["git", "rev-parse", "HEAD:ports/spdlog"], capture_output=True
).stdout.decode()

with open("./versions/s-/spdlog.json", "r") as f:
    version = load(f)

version["versions"][0]["git-tree"] = spdlog_git_tree.strip("\n")

with open("./versions/s-/spdlog.json", "w") as f:
    dump(version, f, indent=2)
