# GoProxy

这是一个 Go 语言的流式透传服务：客户端先把“直链 URL + 必要请求头”注册到本服务，随后通过返回的 token 地址进行播放。本服务会使用注册时提供的 headers 去请求直链并将响应透传给客户端。

## API

- 注册直链
  - `POST /register` body: `{ "url": "<url>", "headers": { ... } }`
- 播放透传
  - `GET /<token>`
- 测速
  - `GET /speed?bytes=2097152`（返回指定大小的随机字节，用于前端测速）

## 运行

```bash
go run .
```

## 配置（环境变量）

- `PORT`：监听端口（默认 `3010`）
