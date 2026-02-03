#!/bin/bash
function git_clone() {
  git clone --depth 1 $1 $2 || true
 }
function git_sparse_clone() {
  branch="$1" rurl="$2" localdir="$3" && shift 3
  git clone -b $branch --depth 1 --filter=blob:none --sparse $rurl $localdir
  cd $localdir
  git sparse-checkout init --cone
  git sparse-checkout set $@
  mv -n $@ ../
  cd ..
  rm -rf $localdir
  }
function mvdir() {
mv -n `find $1/* -maxdepth 0 -type d` ./
rm -rf $1
}

echo "正在克隆分支 $BRANCH_NAME..."
# 注意：这里不能用 --depth 1，因为我们要找的历史 commit 可能在几层之前
# 建议设为 --depth 50 或者干脆不加 depth 以确保能找到该 commit
git clone -b openwrt-24.10-6.6 https://github.com/padavanonly/immortalwrt-mt798x-6.6 ponly && mv ponly/* ./; rm -rf ponly

#echo "正在重置到指定提交 $COMMIT_HASH..."
#cd ponly
#git reset --hard ee09cf9faf7d149e3d1be11453ac88d3c6e891c7
#echo "✅ 成功切换至目标版本!"
#cd ..

# patch


exit 0
