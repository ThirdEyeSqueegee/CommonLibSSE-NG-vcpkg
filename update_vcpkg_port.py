from hashlib import sha512
from re import sub
from subprocess import run
from urllib.request import urlretrieve

clib_repo = "https://github.com/ThirdEyeSqueegee/CommonLibSSE-NG"

clib_ref = (
    run(["git", "ls-remote", clib_repo], capture_output=True)
    .stdout.decode()
    .splitlines()[0]
    .split()[0]
)

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
