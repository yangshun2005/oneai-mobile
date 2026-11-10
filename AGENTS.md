# OneAI Mobile

## 注意事项

1. 每次改动完成后，都必须创建一个对应的 Git commit，以便后续追踪和回滚。
2. 每次改动后，都必须编写或更新相关测试，并在交付给用户前，确保所有测试和验证全部通过。
3. 每次改动完成后都必须检查一下是否严格执行了 PRD 和 Figma 的原型并建立改动台账表，`task/` 目录被 `.gitignore` 忽略。

## 范围

本仓使用 Dart/Flutter 生成 iOS 与 Android 应用。业务 API、认证、RAG、记忆和模型调用由 `oneai-api` 负责；移动端不得保存 provider key、Bifrost key 或 S3 secret。
