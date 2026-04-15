# Zeta4G Standard Edition

Zeta4G는 Cypher 쿼리를 지원하는 고성능 그래프 데이터베이스 서버입니다.

Standard Edition은 HTTP/Bolt 프로토콜 서버, 온톨로지 관리, 스키마 진화 기능을 제공합니다.

## Downloads

[Releases](https://github.com/zeta9044/zeta4g-standard/releases) 페이지에서 최신 바이너리를 다운로드하세요.

| Platform | Architecture | 파일명 패턴 |
|----------|-------------|------------|
| macOS | Apple Silicon (M1/M2/M3/M4) | `zeta4g-standard-<version>-darwin-aarch64.tar.gz` |
| Linux | x86_64 (AMD/Intel) | `zeta4g-standard-<version>-linux-x86_64.tar.gz` |

## Quick Start

### 1. 다운로드 및 압축 해제

```bash
# macOS (Apple Silicon)
curl -LO https://github.com/zeta9044/zeta4g-standard/releases/latest/download/zeta4g-standard-darwin-aarch64.tar.gz
tar xzf zeta4g-standard-*-darwin-aarch64.tar.gz

# Linux (x86_64)
curl -LO https://github.com/zeta9044/zeta4g-standard/releases/latest/download/zeta4g-standard-linux-x86_64.tar.gz
tar xzf zeta4g-standard-*-linux-x86_64.tar.gz
```

```bash
cd zeta4g-standard-*
```

### 2. 데이터베이스 초기화

```bash
./zeta4gctl init --clean -y
```

기존 데이터를 보존하려면 `--clean` 플래그를 생략하세요.

### 3. 서버 시작

```bash
# 인증 없이 시작 (개발/테스트용)
./zeta4gctl start --no-auth

# 인증 활성화 (운영 환경)
./zeta4gctl start
```

기본 포트:
- **HTTP**: `9044`
- **Bolt**: `9045`
- **HTTPS**: `9043`

### 4. 쿼리 실행

```bash
# 단일 쿼리 실행
./zeta4gs "CREATE (p:Person {name: 'Alice', age: 30}) RETURN p"

# 대화형 셸
./zeta4gs
```

### 5. 서버 중지

```bash
./zeta4gctl stop
```

## Binaries

| 바이너리 | 설명 |
|---------|------|
| `zeta4gd` | 그래프 DB 서버 데몬 (Bolt + HTTP) |
| `zeta4gs` | Cypher Shell (대화형 쿼리 CLI) |
| `zeta4gctl` | 서버 컨트롤 (init/start/stop/status) |
| `zeta4g-admin` | 관리 도구 (dump/load/user) |
| `zeta4g-onto` | 온톨로지/스키마 진화 관리 도구 |

## Usage Examples

### 노드 생성 및 조회

```cypher
-- 노드 생성
CREATE (p:Person {name: 'Bob', age: 25})
CREATE (c:Company {name: 'Acme Corp'})

-- 관계 생성
MATCH (p:Person {name: 'Bob'}), (c:Company {name: 'Acme Corp'})
CREATE (p)-[:WORKS_AT {since: 2024}]->(c)

-- 조회
MATCH (p:Person)-[r:WORKS_AT]->(c:Company)
RETURN p.name, c.name, r.since
```

### 데이터 백업 및 복원

```bash
# 백업 (Cypher dump)
./zeta4g-admin dump --output backup.cypher

# 복원
./zeta4g-admin load --input backup.cypher
```

### 온톨로지 관리

```bash
# 온톨로지 생성
./zeta4g-onto create --name "MyOntology"

# 온톨로지 조회
./zeta4g-onto get --name "MyOntology"
```

Cypher Shell에서도 온톨로지를 관리할 수 있습니다:

```cypher
CREATE ONTOLOGY MyOntology;
USE ONTOLOGY MyOntology;
CREATE ONTOLOGY CLASS Person WITH PROPERTIES (name STRING NOT NULL, age INTEGER);
```

### 서버 상태 확인

```bash
./zeta4gctl status
```

## Configuration

서버 설정 파일은 `~/.zeta4g/config/` 디렉토리에 자동 생성됩니다.

| 파일 | 설명 |
|------|------|
| `core.toml` | 스토리지, 트랜잭션, WAL 설정 |
| `server.toml` | HTTP/Bolt 포트, 인증, TLS 설정 |

커스텀 홈 디렉토리 지정:

```bash
./zeta4gctl start --home /path/to/data
```

## HTTP API

서버가 실행 중이면 HTTP API로도 접근할 수 있습니다:

```bash
# Cypher 쿼리 실행
curl -X POST http://localhost:9044/api/cypher \
  -H "Content-Type: application/json" \
  -d '{"query": "MATCH (n) RETURN n LIMIT 5"}'

# 서버 상태 확인
curl http://localhost:9044/api/status
```

## Editions

Zeta4G는 용도에 따라 여러 에디션을 제공합니다:

| Edition | 핵심 기능 |
|---------|----------|
| **Standard** (이 패키지) | 서버, 온톨로지, 스키마 진화 |
| **Pro** | + 벡터 검색, RAG, GraphRAG |
| **HA** | + 고가용성 클러스터 (Raft) |
| **AI** | + 분산 GraphRAG, 분산 벡터 |
| **Ultimate** | + Pregel/BSP 분산 컴퓨팅 |

## Sponsor

Zeta4G 프로젝트가 도움이 되셨다면 후원을 통해 지속적인 개발을 응원해 주세요.

[![Sponsor](https://img.shields.io/badge/Sponsor-Zeta4G-ea4aaa?logo=github-sponsors&logoColor=white)](https://github.com/sponsors/zeta9044)

## Support & Contact

기술 지원 및 문의는 아래 채널을 이용해 주세요.

| | |
|---|---|
| **Telegram** | [@pub_zeta](https://t.me/pub_zeta) |
| **Email** | [zeta4lab@gmail.com](mailto:zeta4lab@gmail.com) |
| **Website** | [https://zeta4.net](https://zeta4.net) |

## License

Proprietary. All rights reserved.

---

**제타포랩 (Zeta4Lab)** | 대표: 최강유 | 사업자등록번호: 570-35-01460

[zeta4.net](https://zeta4.net) | [zeta4lab@gmail.com](mailto:zeta4lab@gmail.com) | Telegram [@pub_zeta](https://t.me/pub_zeta)
