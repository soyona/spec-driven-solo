#!/bin/bash
# ==============================================================================
# 🔨 Spec-Driven 单文件发布打包脚本 (build.sh) - 终极跨平台修复版
# ==============================================================================
set -e

echo "📦 1. 正在进行跨平台纯净压缩 (物理过滤 Mac 垃圾文件)..."
COPYFILE_DISABLE=1 tar --exclude='._*' --exclude='.DS_Store' -czf /tmp/templates_payload.tar.gz templates/

echo "🔐 2. 进行 Base64 编码与格式安全化处理..."
# macOS 与 Linux base64 兼容性处理
if base64 -b 0 /dev/null >/dev/null 2>&1; then
    PAYLOAD_B64=$(base64 -b 0 < /tmp/templates_payload.tar.gz)
elif base64 -w 0 /dev/null >/dev/null 2>&1; then
    PAYLOAD_B64=$(base64 -w 0 < /tmp/templates_payload.tar.gz)
else
    PAYLOAD_B64=$(base64 < /tmp/templates_payload.tar.gz | tr -d '\r\n')
fi
rm -f /tmp/templates_payload.tar.gz

mkdir -p release
echo "🚀 3. 正在生成自包含单文件 release/init_spec.sh ..."

# 写入 Head 引导与 Base64 解压逻辑
cat << 'HEADER_EOF' > release/init_spec.sh
#!/bin/bash
# ==============================================================================
# 🚀 Spec-Driven Solo 自动初始化脚本 (Self-Contained Executable)
# 注意：此文件由 build.sh 自动构建生成，请勿手动修改！
# ==============================================================================
set -e

# 1. 创建安全临时解压物理隔离区
TMP_DIR=$(mktemp -d 2>/dev/null || mktemp -d -t 'spec_init')
trap 'rm -rf "$TMP_DIR"' EXIT

# 2. 嵌入 Base64 模版资产 Payload
PAYLOAD_DATA="
HEADER_EOF

# 安全追加纯文本 Base64 字符串
echo "$PAYLOAD_B64" >> release/init_spec.sh

cat << 'BODY_EOF' >> release/init_spec.sh
"

# 3. 兼容 macOS 与 Linux 的 Base64 解码与解压
if echo "$PAYLOAD_DATA" | base64 -d >/dev/null 2>&1; then
    echo "$PAYLOAD_DATA" | base64 -d | tar -xzf - -C "$TMP_DIR"
elif echo "$PAYLOAD_DATA" | base64 -D >/dev/null 2>&1; then
    echo "$PAYLOAD_DATA" | base64 -D | tar -xzf - -C "$TMP_DIR"
else
    echo "❌ 错误: 本地环境缺少兼容的 base64 解码工具！"
    exit 1
fi

# 4. 自检断路器：校验解压完整性
if [ ! -d "$TMP_DIR/templates" ]; then
    echo "❌ 错误: 模版 Payload 解压损坏或格式不兼容！"
    exit 1
fi

BODY_EOF

# 4. 追加注入核心 CLI 逻辑源码
cat src/cli.sh >> release/init_spec.sh

chmod +x release/init_spec.sh
echo "✅ 构建成功！单文件发布产物已输出至: release/init_spec.sh"