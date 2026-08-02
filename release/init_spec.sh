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
H4sIAMTobmoAA+1baU+byZbuz/4VJUUjkagBs89kRi2RhOlmprMooftqdNXCjnlJPAHbsk13otFIJsFgwBthN6vZQwcbEgLGZvkvHVe9rz+lf8KcU6dsbENu7r1KaF0N9SGAXXXq1Fmes1TFq3W7uqxezVP91RcbZrO5qaGByZ+N9NNcW08/1WA1DbV15sbaGnOtmZlr6hprzV+xhi/H0uno8XitbmDlidXxqEuzf3QeTOvs/At01DkKP/9Bhregf3dP1xeygr9W/3UNjfU1DTWg//qmpkv9X8g41b/L7ey0fxET+Nv9v6G+vu5S/xcxTvX/0OrRvkwQ+Nv8vw79v6Gh9lL/FzHK9N9h9VpvOzu0Lk9Vd0eV19X1OfYAeTTW139c/wD2Bf9vbET/b2qqb/iKmT/H5p8a/8/1f4X9vjA6x9qeubQHNrfd5WUivMojy9lUmP3Hg7t32APbY63byngilj0YZBUlBnLVZPqGiUhUX0l/OIyJ2ddiYiCb2aO5eqxPjG+LUELPjIr5vg+HQX7iz8UzrMZs/iemD77So/1iapFv9+XGZ/mLiDHwllk8blu1F3jxVNsdHdrTKq/HwrKprfe+5ybTlSuspoqJxRQ/ecET89mjUbER5/PDrOKm062xW85uq93BiDngzGKxSEryVKbqagZcZo+HgVG+kNbjvpwvpo9tECG+OqKn10zaU5fT7WV2h1dzd1ptGrsBPtHi8Nq9z9j/mBizd1xnHq/b7nj0r/CXza2B43Q0e68zR0/3Q82NH/a4Oso//F9kRbJfW8Wa77UyPhri6THan4TDKvBzEvUZ1s9w1eyy39c8LqfDo/1b2zeSMxucupiNbs3jsT7SitlFzV1nbYqfvP7L/N+r2R7fdMJOT72fDwA+4f815rraUvyvhQyg8dL/L2JcYb/Fpj+kIkwM+cRsMns8Z7ybAOc3TqJGPAhOIeYWWEWpWVyVxvxbbEKum98DA+apAE/ExcKqPrQnfL1gz27bY3Zf+9mu/XLVVMmuXePgZYMh+vratevsXsudW613vpXfIYFMWgQBPFbwO0t7+827t++1ft/SfvP2rfZ2i5xFa/WtCX18Vc160Nbc1gL/3ocf3/4XTjRVVlZK9n5fmBlhfKCf+1fpUPr0EY+GeGicVfzpsd2rddk93qsmIHK7pa25/U/ftba1fN/6oE0SwePNBRkf2oAd4WBGIp7LjOSX3+iy2p6ULr/xffPN/ywsL+IhjjLSw0m+9IKECbLlhz4eGeH7q9y/nxs9hsOJ8IYRivKgX0/EARb59MZ1Y2ATtjeS/Tzwqw57J2KswuJwdVuqLS768bDHAf8+s7odFhSxfjhhJBVVHorrzw+uM0JcQBrjZKAY47OpVbF4qO9kAD7Fsg/0BsS9HhurrHQ4W7rtXqD4R1vm5biIUYb/nmce+OSe1QuxxvG5csBP4X9NTW0h/2uor0X8b6qtu8T/ixgIUpHJUyDHlOowAiClzyT40TgffcO31ljFGbu4WpqPFS8m8AeEtXl7IC/LL6Iw8EMr09NJPdMHeSJCYeIAwI4H+vW1jMR0TABtzm5IbjSH11MN2V/Gb+wuGLvLYnKRIkA1EOA745DOsR9aIa3MpmJ8KJ7zZYzjETG2J4aXsukwUeqyPwQSIjDBboKend3sO6fziQezSRlQJP4BpIt0VJ9dAOBlFQ/saAbsgbPHDZmWs5O1uXu8j68ib2IQIiSmtdy/wXd8arXMHPUM4LqPz26cn8Hy5CEfSGMGfLBHKS+zlCTSlnyCCxliqeBv2d0gR6f7Gbv32N7l9Dhdj5+hJIv2sQDOH6aJHUql898XCxImhRf4FgSZCYzDvyYZqkLqIT9dSut6PsOmQDJwBEn8e1+vzFsTSyKwD0tBccVC59u9xrL/j7bky/H3jDL8d7md/w32dsNt1zo/WwHw6fy/6RT/zRL/a5su8/8LGYj/4STLptf5aK/oOxHT6N0EAUbwBZ/ZZRVlRlGAfrWIAoBcqkrxH+0eu9NBgJ+LHyCiRUP6+jaiaHv7vft3/x1T+zvNt1va25k+eICYtL+qbwxTNSAJwiKxOIAr/mwk9wFaxdaKiESMk23a1lhf5v1vsclA0ydnIOP9KQ+iCsOGFowXR/ljtDoqH9icLg35+jP7iVEbgDbObW5gCItuQR2CwY+wPXmQO4qq2USR3f7xHiPsI+I8Ma+Ht+W2dbDt1DEEwNzcPHHPKlqeurrsNruX3e3xVjo7iQFWze44HZXfOq3YqPgGQtxqNjXM+/0QDcXs69zUnki8gxRdX4NTrulL2xA5cr0n3B9itP6mW9NcHw5jwBqWKSL2PJsK8cNxqHX4SkjMPc8NhDhEJRkueXr0w2GArz2Hcqyj5+mHw8GSZcbJDBR6YnZThANi7gUKVMZyIAH//tHmeTm+8DiL/4/cmudzdn//iv5vTUNR/6ce+79QBlzi/0UM2f8dYjySFIPrAAQAB4AcIuWXnY4ic7iqOhqxNUaQnhsIAnDqSyOs4jbeG3oh0/TIWVcgVwVjYjXXFcYaiWMxcQS4WgyziKtPf1KNYEJhSn3F4gj1iAl/eWCOrw9DiFALbkLS/JRRe4RHRgB9EfYiy6zC0vxty522B5hPX2W4m+TTWO/jgWn4tgqbpE/lNTd8b0SP9JkpBe7nZu1GHDLgjdxSP19YoE62ahMXh49c/F1ubglDhkyl1QFTb8TCqHg3bCTHiwVSe13GDwolJRk0RREVacKw7yp2iqtpW/GuN79nIigC0ZL1k1t6OKm2+jv0X+b/VpvX/rP2mTvAn/J//LLE/2vNDTVNl/5/EQP7uHHGQ2/F5B4hQDY1BNmImIDspdwa8hgACSO1c43emN63xtqsnidQ9cvZ8g+V+slEBlM4lQTmPZnMGOvhgX6+MkApiHQN/fVrKKRpIbVJ88V6ef/494X1RVbgle+/4ds7emYTiBKinIsl+TL794WX+UNjErmFHW9IfnhiNnswbCTihcPc0mwyl5XdiwL/uAw2lKfANnRpRmth9+gpBaO+LZ2guLlL/W4+cpTNrAAhmpZNpc/pfOPiL6n/8vc/1kfYLvis4f+T/t/QVBz/azH+15trLv3/IsYVqApcTo9dtphaHR6vuwcsHwzedEPrxFquw2l3PGJWxzP2i9P9hNkdzPvY7mHuwqqv4XdrB8zoYJ3Ori7nL6wk0jJsQnVpXq3rWZXJ1NpZ9i2Q6rZ7PLiH0816HEjL+rBL+xo2Zg6nl3U7O+ydz2BTrWjPKsm12ys/Pnc9Q/oMvRB2bcOb2rKNrZ4ympUeFzh7p93GPIXmnxebf1XsO/ujx5q70uW2O914F0zdUGBR+1nrgoLM/bU8vq3H7QbvYT0ezQ2COpUl83jtXV3Ma32iMZdbs2kdmsMGjP3Ryv/qrP+fiuii7n9rzHUNdaXv/2rNtY2X8f9CxhWVT6sIHYpkj2YpY/5wGChyGGwb5Dv+8p42ezjF/QE9vY6hU7YOjOMDfTxoMsEU/W1Gzyy89/Xyg7c8ss1fBimYGz5/8epsOlx4NIKBDrvfYxsisK+yi+S+2HlemKpYDPfzyBvKAz4czli6tW503odWxxO8LUiF+PGksQbhf6KYFHGIe9RVQRzvF/PR9/mbXfjFWF/ODQzhL8k++BD4lTJ4SRzkMlNGYoVHNo1kBknUVzEjOSQmtuhr7u81EilKnviJ31jr1WN92ANa3OVzEeFbpxtWvKk46seOC5UuiXmsiU4SfCWERBuAr8gmXjBItsVUWI8ngBZK4CQhxg4kv1gmiMCEujCf3AOiYjBEHPDZDWKIGl7YT+qfhkriVL6qOYa62F+Fw/DIhLGf1Md2THgHLa83SMjZTAY7XP4ATWIlUi5rB1oYiKt0RulzAYtKgKQFKMr9ofMol+eb55AuqkgVXbE3yCNDxQUayOU86mdvXAqL6fbq/GVnrr7UUrIKHTS0tXTuYfAS7Get2gJW+jHNGidHIp0kk5YJeAgKcSKmhCaNDv6kZFNJ78Sfm/WBkZGjonft+HIvNqiDKG/E8m29yUXqREIhm82MisFfRSSStwTsV9LjjURcDB7kJjfgMGgJf0mXrNAgLH7vAbkrs6gXHRZGdklGmT9Mb5nTAdMiEuUDaTFxIOIBcg4SJk8MGst+erQBtk7Wr0y/YMqVeW853b/5HuThP7bcQhQYO4sjBAHkdmWeg00P/yptRLUHbaHQZGATRTk0VHzEsYPSPUHJRlJJAxwqm8YLucLbGFR4YoWIktLoJHA8QoxCIaMfpvnKznt5JP1VGs+fUkahxNo7izKSns0P9qCCAuJiaJWPDNFa8OC8hgGoyJ+pGDJ6g8bustQwuFEHJCeVVo9Hw9vBD4cxxXIkmj2eASWrLvs7/AX7z0UYCGfNZvwAN2cNGnjMo9XzckvCTRS85E+LN8Cy/jIS28Ag6iQ4SEZOhoOfZOLG3ls+Mw9nFnNxlBp4ysyumNhWm2DzRp6A+vJkKemovtirJkB6g4cEqeb8If0ogUDfh+8V0QonBkR8GVfLbcGx8CRQ4EnLoMOQS/HI5G++WRTBiyP6XG39m28uNx3lgb1zDl2EAjHeDwb5EnbjwXRBpOireR+B30+lhwqEoEAfyKvyQfBish7UofILiG0yvACiQ+gGyvnQGMyezOnj08oR9t+As+D8oQ0FEDJGogHOzItMDJCC+98W6w5UnHc9hJ5iVyoAEFkx1tzSc3PxNE+t0c0BRqmUH+pdBbQT23xpXh9bAHMi15bUdsF4yAMgTqJdlT7VMuIb+kqaVJHzDYrhV4p5+ly+biK4KDhsQZjG8SjAC/yCJp1ewZOS0yT7cy9XEYiS/dJEgPiKkexVb1dfBnOxqL7eSwGFyJ5G8tEQClnuSz5N/qdA9mDPCO8DYpBHnOYcqMrGKtUzUR4pa37jKMEzoybV4FjCxw30Dk8sBq5dA5M521ygzoo0ndJnczT74+/mZPMh/3qOJp/zfA6blee+mjN99KncFUZTCy/kTB95Fidp51+90Ws4k6m9ve3u3e9vftfceqf9/t0f2lrut7dLgTVVMbLp3FKfnphED1jZMXZX+UofHER6AGWGRyf4jvbNMYp82afvLqFuZUBUoRPiYyLGoyO5zSDomSwIb8hWlLGI2U0emeJBgNoxdJQwhKY4vvOQ8VRZFrlCNKyMEWx8YpuWk/LJfLIZeQO3mJLvemdVpNp/o4ODghuN7ypnPfHrfXt0HoTMAj/y1SWifHpMOQetlTMpwS6OfjwalO2yDI/P4/OOmUXjZF7PbBE1tP03cfR7ZLUXzBkOCI4u3o7rmXWYhs8OT2ZOgyGFFrBi8vJUgg+9QqeUYRCRGX6JBnNj00YyCfLREz58PPM6jr4ymxZL23r/GKTFyuPfRYz1AJ/ekPl1v7E+CIrQZxdgpnpbEtksxBCKHgiBmVGeHgVNibE9FVLAcSNTAPigX8D2AkCT3vPu9c8Q6qR68e2qPGu+HCnSHRkMCRntichCKAmv6jMpwD9UujQVaqgDP8VvJIGT3Nw0+BL9qY4JQJgJKOWSQ876+Eosv4sP5KNURnAVTEMqVLZLKdneYmqoxLwk6YTIlRQj/QlShdANIiWhneaNL44oLUChTftVfXKwR69BsUQpcgc5eUixka8vyIYBa/HSPZUmJRZ2x9SkaF8im1fHv1Sx2zIKshsQBRlFb9Op3coYrRgD1USmFCpKqMIjU+YkcwPYSN1KyQyZQn9ZaqFOnc8xc5MJfWsMHZ/yZ/WCV8XbkuThnJoD1sh0hPA6mwmhC40HMCk6k7goKsVlCRLgw8cQr2RvN6LiJ0heClzmVsMqS6Mck+KSVDrYkv5rUkwCRExSjKJgBa4K1iLTQbQoiEXqUbGSmDw+JRc784ViWYFSPolRFji7oZrplL5R8Z6vGclOCv/hwlylLp0ghGYzUyaTsndQ6Ar+LwbAAHBHwip8kXDqbqoYmSEAJLJFVjcjfWez7HMoxgjHCgsB/XLL4dz0q3J7iyviYirJo2vKKkqMDmj594jcl26jX47LcTkuxz/c+D+qzqdLAEIAAA==
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

# ==============================================================================
# 🛠️ Spec-Driven 核心交互与 100% 物理对齐渲染引擎 (src/cli.sh)
# ==============================================================================

PROJECT_NAME=$1
if [ -z "$PROJECT_NAME" ]; then
    CURRENT_DATE=$(date "+%Y%m%d")
    PROJECT_NAME="spec-app-$CURRENT_DATE"
fi

if [ -d "$PROJECT_NAME" ]; then
    echo "⚠️  警告: 本地已存在同名目录 [${PROJECT_NAME}]"
    echo "--------------------------------------------------------"
    echo " [1] 覆盖初始化 (⚠️ 危险操作)"
    echo " [2] 终止退出"
    echo "--------------------------------------------------------"
    read -p "请输入选项数字 (1/2): " CONFLICT_CHOICE </dev/tty
    case $CONFLICT_CHOICE in
        1) rm -rf "$PROJECT_NAME" ;;
        *) echo "🛑 操作已取消。"; exit 0 ;;
    esac
fi

# 1. 自动识别本地包管理器
PKG_MANAGER="npm"
RUN_CMD="npm run"
if command -v bun &> /dev/null; then
    PKG_MANAGER="bun"
    RUN_CMD="bun run"
elif command -v pnpm &> /dev/null; then
    PKG_MANAGER="pnpm"
    RUN_CMD="pnpm"
elif command -v yarn &> /dev/null; then
    PKG_MANAGER="yarn"
    RUN_CMD="yarn"
fi

echo "--------------------------------------------------------"
echo "🎨 请选择您的产品形态与技术轮廓 (Tech Profile):"
echo " [1] Web/SaaS 轻量通用型 (Vite Standard) [默认]"
echo " [2] 微信跨端小程序 (Taro 4.x)"
echo " [3] 跨平台桌面端应用 (Tauri 2.x)"
echo " [4] 复杂数据/BI 后台管理 (Next.js)"
echo "--------------------------------------------------------"
read -p "请输入选项数字 (1-4, 默认 1): " PROFILE_CHOICE </dev/tty
[ -z "$PROFILE_CHOICE" ] && PROFILE_CHOICE=1

case $PROFILE_CHOICE in
    2)
        PROFILE_NAME="微信跨端小程序 (Taro 4.x)"
        COMPILE_CMD="$RUN_CMD build:weapp"
        STATE_STRATEGY="React Context 局部隔离"
        META_WHITELIST='[ "@tarojs/components", "@tarojs/taro", "lucide-react" ]'
        META_BLACKLIST='[ "vant-weapp", "miniprogram-custom-render" ]'
        TOOLCHAIN_ROUTER="- 断路器 1：只能在本地通过 Taro CLI 进行静态编译。\n- 断路器 2：构建体积超 2MB 物理极限必须触发强熔断。"
        ;;
    3)
        PROFILE_NAME="跨平台桌面端应用 (Tauri 2.x)"
        COMPILE_CMD="cargo check && $RUN_CMD build"
        STATE_STRATEGY="前端 Context / Tauri IPC 持久化"
        META_WHITELIST='[ "tauri-plugin-fs", "wasm-bindgen", "serde", "tokio" ]'
        META_BLACKLIST='[ "child_process", "fs.writeFileSync", "panic!" ]'
        TOOLCHAIN_ROUTER="- 断路器 1：必须同时监控前后端编译器。\n- 断路器 2：Rust 侧严禁原生 panic!，连续 3 次报错强熔断。"
        ;;
    4)
        PROFILE_NAME="复杂数据/BI 后台管理 (Next.js)"
        COMPILE_CMD="$RUN_CMD build"
        STATE_STRATEGY="特许解禁 Zustand 局部切片订阅"
        META_WHITELIST='[ "zustand", "echarts", "shadcn-ui", "next" ]'
        META_BLACKLIST='[ "recharts", "DOM轮询重绘", "redux" ]'
        TOOLCHAIN_ROUTER="- 断路器 1：Next.js App Router SSR 双向走查。\n- 断路器 2：严禁因依赖项配置错误导致高频重渲染。"
        ;;
    *)
        PROFILE_NAME="Web/SaaS 轻量通用型 (Vite Standard)"
        COMPILE_CMD="$RUN_CMD build"
        STATE_STRATEGY="React Context 纯函数状态机"
        META_WHITELIST='[ "vite", "tailwindcss", "react-router-dom" ]'
        META_BLACKLIST='[ "redux", "webpack", "gulp" ]'
        TOOLCHAIN_ROUTER="- 断路器 1：标准 Vite HMR 及严格 TS 编译期卡点。\n- 断路器 2：严格执行 Lint -> Build 连续编译防线。"
        ;;
esac

# 2. 100% 物理创建目标工程目录树规范
mkdir -p "$PROJECT_NAME" && cd "$PROJECT_NAME"

# 🎨 资产轨
mkdir -p product-assets/PRD
mkdir -p product-assets/wireframes
mkdir -p product-assets/research

# 🧠 记忆轨
mkdir -p memory-bank/archive

# 🛠️ 源码轨
mkdir -p src/types
mkdir -p src/components
mkdir -p src/lib

# 3. 纯 Bash 字符串模版渲染函数
render_template_file() {
    local src_file="$1"
    local dest_file="$2"
    local content
    
    if [ -f "$src_file" ]; then
        content=$(cat "$src_file")
        content="${content//__PROFILE_NAME__/$PROFILE_NAME}"
        content="${content//__COMPILE_CMD__/$COMPILE_CMD}"
        content="${content//__STATE_STRATEGY__/$STATE_STRATEGY}"
        content="${content//__META_WHITELIST__/$META_WHITELIST}"
        content="${content//__META_BLACKLIST__/$META_BLACKLIST}"
        content="${content//__TOOLCHAIN_ROUTER__/$TOOLCHAIN_ROUTER}"
        
        mkdir -p "$(dirname "$dest_file")"
        echo "$content" > "$dest_file"
    fi
}

# 4. Codex 自动发现入口与项目规则落盘
render_template_file "$TMP_DIR/templates/rules/codexrules.md.tpl" ".codexrules"
render_template_file "$TMP_DIR/templates/rules/agents.md.tpl" "AGENTS.md"

cat << 'EOF' > .gitignore
# ⚙️ 依赖与产物
node_modules/
dist/
out/
.DS_Store
*.log

# 项目本地状态与冷归档
memory-bank/archive/
memory-bank/*_historical_logs.md
product-assets/research/tech-review.md
EOF

# 5. 资产轨：冰封资产落盘
cat << 'EOF' > product-assets/research/tech-review.md
# ❄️ 【冰封资产】红队论证与底层技术选型结论
> 本文件为云端上游红队论证产物，Agent 仅允许读取，严禁修改。
EOF

# 6. 记忆轨：补齐 6 大持久化核心大脑文件
render_template_file "$TMP_DIR/templates/base/projectBrief.md.tpl" "memory-bank/projectBrief.md"
render_template_file "$TMP_DIR/templates/base/techContext.md.tpl" "memory-bank/techContext.md"
render_template_file "$TMP_DIR/templates/base/systemPatterns.md.tpl" "memory-bank/systemPatterns.md"
render_template_file "$TMP_DIR/templates/base/dataModels.md.tpl" "memory-bank/dataModels.md"
render_template_file "$TMP_DIR/templates/base/activeContext.md.tpl" "memory-bank/activeContext.md"
render_template_file "$TMP_DIR/templates/base/progress.md.tpl" "memory-bank/progress.md"

# 7. 源码轨与基础配置文件落盘
touch src/types/index.ts
touch src/main.ts

cat << 'EOF' > tsconfig.json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "ESNext",
    "moduleResolution": "bundler",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"]
    }
  },
  "include": ["src/**/*"]
}
EOF

cat << EOF > package.json
{
  "name": "$PROJECT_NAME",
  "version": "0.1.0",
  "private": true,
  "type": "module",
  "scripts": {
    "build": "$COMPILE_CMD"
  }
}
EOF

echo "--------------------------------------------------------"
echo "✅ [$(uname)] Spec-Driven 项目初始化成功！"
echo "📂 项目物理路径: $(pwd)"
echo "⚙️  自动化绑定: 包管理器 [$PKG_MANAGER] | 编译指令 [$COMPILE_CMD]"
echo "--------------------------------------------------------"
