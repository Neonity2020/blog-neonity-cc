#!/bin/bash

# 为缺少category字段的博客文章添加category

# 定义文章和对应的category
declare -A articles
declare -A articles=(
    ["ai-munger-talk.md"]="Investment"
    ["astro-blog-setup-guide.md"]="Technology"
    ["build-your-ai-mentor-system.md"]="AI"
    ["claude-code-tutorial-astro-blog.md"]="Technology"
    ["li-ji-kai-shi-ni-de-shi-ye.md"]="Business"
    ["markdown-style-guide.md"]="Technology"
    ["recommend-free-astro-template.md"]="Technology"
    ["start-your-own-business-rightnow.md"]="Business"
    ["why-astro-is-perfect-for-your-blog copy.md"]="Technology"
    ["why-deliberate-practice-fails.md"]="Learning"
    ["why-now-is-the-best-era-for-solo-business-and-lifelong-learners.md"]="Business"
    ["why-vscode-is-the-best-note-app.md"]="Productivity"
)

# 遍历每篇文章
for file in "${!articles[@]}"; do
    category="${articles[$file]}"
    filepath="src/content/blog/$file"

    if [ -f "$filepath" ]; then
        # 检查是否已有category字段
        if ! grep -q "^category:" "$filepath"; then
            # 在tags行后面添加category字段
            sed -i "/^tags:/a\\
category: '$category'" "$filepath"
            echo "Added category '$category' to $file"
        else
            echo "Category already exists in $file"
        fi
    else
        echo "File not found: $filepath"
    fi
done