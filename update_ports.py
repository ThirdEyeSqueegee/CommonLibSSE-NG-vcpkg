from hashlib import sha512
from json import dump, load
from re import sub
from subprocess import run
from urllib.request import urlretrieve

clib_repo = "https://github.com/ThirdEyeSqueegee/CommonLibSSE-NG"
spdlog_repo = "https://github.com/gabime/spdlog"
vcpkg_repo = "https://github.com/microsoft/vcpkg"

clib_ref = (
    run(["git", "ls-remote", clib_repo], capture_output=True).stdout.decode().split()[0]
)

spdlog_ref = (
    run(
        ["git", "ls-remote", "--tags", "--sort=-v:refname", spdlog_repo],
        capture_output=True,
    )
    .stdout.decode()
    .split()[0]
)

vcpkg_ref = (
    run(["git", "ls-remote", vcpkg_repo, "refs/heads/master"], capture_output=True)
    .stdout.decode()
    .split()[0]
)

# Update vcpkg.json
with open("./ports/commonlibsse-ng/vcpkg.json", "r") as f:
    vcpkg_json = load(f)

vcpkg_json["builtin-baseline"] = vcpkg_ref

with open("./ports/commonlibsse-ng/vcpkg.json", "w") as f:
    dump(vcpkg_json, f, indent=2)

# Update CommonLibSSE-NG portfile
clib_archive, _ = urlretrieve(f"{clib_repo}/archive/{clib_ref}.tar.gz")

with open(clib_archive, "rb") as f:
    clib_sha = sha512(f.read()).hexdigest()

with open("./ports/commonlibsse-ng/portfile.cmake", "r") as f:
    portfile = f.readlines()
    portfile[3] = sub(r"(REF).*", f"REF {clib_ref}", portfile[3])
    portfile[4] = sub(r"(SHA512).*", f"SHA512 {clib_sha}", portfile[4])

with open("./ports/commonlibsse-ng/portfile.cmake", "w") as f:
    f.writelines(portfile)

# Update spdlog portfile
spdlog_archive, _ = urlretrieve(f"{spdlog_repo}/archive/{spdlog_ref}.tar.gz")

with open(spdlog_archive, "rb") as f:
    spdlog_sha = sha512(f.read()).hexdigest()

with open("./ports/spdlog/portfile.cmake", "r") as f:
    portfile = f.readlines()
    portfile[3] = sub(r"(REF).*", f"REF {spdlog_ref}", portfile[3])
    portfile[4] = sub(r"(SHA512).*", f"SHA512 {spdlog_sha}", portfile[4])

with open("./ports/spdlog/portfile.cmake", "w") as f:
    f.writelines(portfile)
