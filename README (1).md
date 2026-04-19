# 🔐 Mission: ProjectA

**KOPO Daejeon · Dept. Cloud Security**

---

## 📌 미션 개요

팀 전용 금고 디렉토리를 만들고, 외부인 접근을 완전히 차단한다.

```
[팀원1, 팀원2]  →  /projectA (770)  ✗  outsider
```

---

## 🚀 실습 코드

### 0. root 전환

```bash
sudo -i
```

---

### 1. 그룹 만들기

```bash
groupadd projectA
```

```bash
# 확인
grep projectA /etc/group
```

---

### 2. 팀원 계정 만들기

```bash
useradd team_member1
useradd team_member2
```

```bash
passwd team_member1
passwd team_member2
```

```bash
# 확인
ls -l /home
```

---

### 3. 팀원을 그룹에 넣기

```bash
usermod -aG projectA team_member1
usermod -aG projectA team_member2
```

> ⚠️ `-aG` 에서 `-a` 빠지면 기존 그룹이 삭제됨! 반드시 `-aG` 같이 써야 함.

---

### 4. 금고 디렉토리 만들기

```bash
mkdir /projectA
```

---

### 5. 그룹 소유권 설정

```bash
chown :projectA /projectA
```

---

### 6. 권한 설정 (외부인 차단)

```bash
chmod 770 /projectA
```

> `770` = 팀원 전체 허용 ✅ / 외부인 완전 차단 ❌

---

## ✅ 증명 (제출용)

```bash
# 팀원 그룹 확인
id team_member1
id team_member2

# 디렉토리 권한 확인
ls -ld /projectA
```

**예상 출력:**
```
drwxrwx--- 2 root projectA 4096 ... /projectA
```

---

### 외부인 차단 테스트

```bash
useradd outsider
passwd outsider
su - outsider
ls /projectA
```

**예상 출력:**
```
Permission denied  ← 성공! 🔒
```

---

## 📋 전체 명령어 한눈에 보기

```bash
sudo -i
groupadd projectA
useradd team_member1
useradd team_member2
passwd team_member1
passwd team_member2
usermod -aG projectA team_member1
usermod -aG projectA team_member2
mkdir /projectA
chown :projectA /projectA
chmod 770 /projectA
id team_member1
id team_member2
ls -ld /projectA
```

---

## 🔢 권한 번호 의미

| 숫자 | 기호 | 의미 |
|------|------|------|
| 7 | `rwx` | 읽기 + 쓰기 + 실행 |
| 0 | `---` | 아무것도 안됨 |

`chmod 770` → 소유자`7` 그룹`7` 외부인`0`
