# 🔐 Mission: ProjectA — Linux Permission Architecture

> **Dept. Cloud Security, KOPO Daejeon**  
> Assignment: Design a secure collaborative group environment using Linux user/group/permission controls.

---

## 🎯 Mission Objectives

| # | Task | Status |
|---|---|---|
| 1 | Design a new collaboration group `projectA` | ✅ |
| 2 | Create 2 new team members and assign to group | ✅ |
| 3 | Create `/projectA` vault with permission firewall | ✅ |
| 4 | Block all outsider access | ✅ |
| 5 | Prove with `id` and `ls -l` | ✅ |

---

## 🏗️ System Architecture

```
[Fenced Group: projectA]  ──►  [Vault: /projectA (770)]  ──✖──  [Outsider]
   team_member1
   team_member2
```

- **Permission 770** = `rwxrwx---`
  - Owner: full access (rwx)
  - Group (`projectA`): full access (rwx)
  - Others: **no access** (---)

---

## ⚙️ Step-by-Step Commands

### Step 1 — Create the Group

```bash
sudo groupadd projectA
```

> Creates a new group called `projectA`. Verify with:
```bash
grep projectA /etc/group
```

---

### Step 2 — Create 2 Team Members

```bash
sudo useradd team_member1
sudo useradd team_member2
sudo passwd team_member1
sudo passwd team_member2
```

> Each `useradd` creates a user with a home directory and unique UID.  
> `passwd` sets their login password.

---

### Step 3 — Assign Members to `projectA`

```bash
sudo usermod -aG projectA team_member1
sudo usermod -aG projectA team_member2
```

> ⚠️ The `-a` flag (append) is critical — omitting it would **overwrite** existing group memberships.

---

### Step 4 — Create the `/projectA` Vault

```bash
sudo mkdir /projectA
```

---

### Step 5 — Set Ownership and Permission Firewall (770)

```bash
sudo chown :projectA /projectA
sudo chmod 770 /projectA
```

**Why 770?**

| Category | Permission | Octal |
|---|---|---|
| Owner | rwx (read + write + execute) | 7 |
| Group (`projectA`) | rwx (read + write + execute) | 7 |
| Others | --- (no access) | 0 |

> This is the "Vault" pattern: only members of `projectA` can enter, read, and write. All outsiders are denied.

---

## ✅ Verification (Proof)

### `id` — Confirm Group Membership

```bash
id team_member1
```
**Expected output:**
```
uid=1001(team_member1) gid=1001(team_member1) groups=1001(team_member1),1003(projectA)
```

```bash
id team_member2
```
**Expected output:**
```
uid=1002(team_member2) gid=1002(team_member2) groups=1002(team_member2),1003(projectA)
```

---

### `ls -ld` — Confirm Vault Permissions

```bash
ls -ld /projectA
```
**Expected output:**
```
drwxrwx--- 2 root projectA 4096 Apr 19 12:00 /projectA
```

| Character | Meaning |
|---|---|
| `d` | It is a directory |
| `rwx` | Owner has full access |
| `rwx` | Group (`projectA`) has full access |
| `---` | Others have **zero** access |

---

## 🚫 Outsider Access Test

```bash
sudo useradd outsider
sudo passwd outsider
su - outsider
ls /projectA
```

**Expected output:**
```
ls: cannot open directory '/projectA': Permission denied
```

> ✅ This confirms the permission firewall is working. The outsider is completely blocked.

---

## 🧠 Key Concepts Applied

| Concept | Application |
|---|---|
| **Principle of Least Privilege** | Others get `0` — no access unless explicitly needed |
| **Group-based Permission Scaling** | Adding new members to `projectA` instantly grants vault access |
| **chmod 770** | Owner + Group: full control. Everyone else: denied |
| **`usermod -aG`** | Safe group assignment without losing existing memberships |
| **Authentication / Authorization / Auditing** | `passwd` (auth) → `chmod`/`chown` (authz) → `id`/`ls -l` (audit) |

---

## 📁 Full Command Summary

```bash
# 1. Create group
sudo groupadd projectA

# 2. Create team members
sudo useradd team_member1
sudo useradd team_member2
sudo passwd team_member1
sudo passwd team_member2

# 3. Assign to group
sudo usermod -aG projectA team_member1
sudo usermod -aG projectA team_member2

# 4. Create vault directory
sudo mkdir /projectA

# 5. Set group ownership and permissions
sudo chown :projectA /projectA
sudo chmod 770 /projectA

# 6. Verify
id team_member1
id team_member2
ls -ld /projectA

# 7. Test outsider (blocked)
sudo useradd outsider
su - outsider
ls /projectA   # → Permission denied ✅
```
