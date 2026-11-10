# OneAI Flutter 移动端

## 选型

移动端采用 Dart/Flutter，一套业务代码生成 iOS 和 Android。界面、语言和 API 契约与 `oneai-web` / `oneai-api` 共用；不会复制模型调用、记忆或 RAG 逻辑到客户端。

## 弱网与多语言

- 草稿按 `user_id/session_id/mode` 保存，最大 20,000 字符。
- SSE 断开时保留会话 ID 和输入，用户可明确重试，避免重复计费。
- 个人知识库调用 `featureMode=personalKnowledge`，服务端继续执行用户/文档隔离和无命中拒答。
- 文档上传使用 API 的 `processing` 状态，移动端轮询，不阻塞手机网络请求。
- API token 使用系统安全存储接入层；provider key、Bifrost key、AWS/S3 secret 永不进入 App。

## 构建

```bash
flutter pub get
flutter test
flutter run -d ios
flutter run -d android
```

本机当前未安装 Flutter/Dart，因此平台工程生成和真机测试待 Flutter 工具链可用后执行；本仓先提供可审阅源码、测试和 API 接入契约。
