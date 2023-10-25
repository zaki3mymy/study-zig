export VERSION=0.11.0

git clone https://github.com/zigtools/zls
cd zls
git checkout -b build-$VERSION refs/tags/$VERSION
zig build -Doptimize=ReleaseSafe

echo =================================================
echo "Open VSCode setting. And configure ZLS settings."
echo "  Search \"zig.zls.buildRunnerPath\""
echo "    and set \"`pwd`/src/special/build_runner.zig\""
echo
echo "  Search \"zig.zls.path\""
echo "    and set \"`pwd`/zig-out/bin/zls\""
echo 
echo "Finally, restart VSCode!"
echo =================================================
