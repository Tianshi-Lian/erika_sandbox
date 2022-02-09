import _globals
import _helpers
import subprocess
import sys


args = _helpers.process_args(sys.argv)
config = _helpers.get_arg_value(args, ["config", "c"], _globals.BUILD_CFG)

exit_code = 0
if _globals.PLATFORM == "linux":
    process = subprocess.run(["make", "config={}".format(config.lower())]) # make uses lowercase config regardless of what is in premake5
    exit_code = process.returncode
elif _globals.PLATFORM == "windows":
    process = subprocess.run(["msbuild", "/property:Configuration={}".format(config)])
    exit_code = process.returncode

sys.exit(exit_code)
