#!/bin/bash

# 안녕하세요! 리눅스 숙제를 해봤어요.
# 이 스크립트는 'ProjectA'라는 가상의 프로젝트를 위한 환경을 만드는 거예요.
# 그룹도 만들고, 사용자도 만들고, 중요한 파일들을 보관할 폴더도 만들 거예요.

# 🚨 중요! 이 스크립트는 'sudo' 권한으로 실행해야 해요.
# 터미널에 이렇게 입력하면 돼요: sudo bash homework_script_ko.sh

echo "🚀 ProjectA 설정 시작!"

# 1. 'projectA'라는 새 그룹 만들기
echo "1단계: 'projectA' 그룹을 만들고 있어요..."
sudo groupadd projectA

# 그룹이 잘 만들어졌는지 확인하는 부분이에요.
if [ $? -eq 0 ]; then
    echo "✅ 'projectA' 그룹이 성공적으로 만들어졌어요!"
else
    echo "❌ 'projectA' 그룹을 만들지 못했어요. 이미 있을 수도 있어요."
fi

# 2. 'user1'과 'user2'라는 새 팀원(사용자) 만들고 'projectA' 그룹에 넣기
echo "2단계: 'user1' 사용자를 만들고 'projectA' 그룹에 추가하고 있어요..."
sudo useradd -m user1 -g projectA
# user1의 임시 비밀번호를 설정해요. 나중에 꼭 바꿔주세요!
sudo passwd user1 <<EOF
user1pass
user1pass
EOF

echo "'user2' 사용자를 만들고 'projectA' 그룹에 추가하고 있어요..."
sudo useradd -m user2 -g projectA
# user2의 임시 비밀번호를 설정해요. 이것도 꼭 바꿔주세요!
sudo passwd user2 <<EOF
user2pass
user2pass
EOF

# user1이 잘 만들어졌는지 확인!
if [ $? -eq 0 ]; then
    echo "✅ 'user1' 사용자가 만들어지고 'projectA' 그룹에 들어갔어요."
else
    echo "❌ 'user1' 사용자를 만들지 못했어요. 이미 있을 수도 있어요."
fi

# user2도 잘 만들어졌는지 확인!
if [ $? -eq 0 ]; then
    echo "✅ 'user2' 사용자가 만들어지고 'projectA' 그룹에 들어갔어요."
else
    echo "❌ 'user2' 사용자를 만들지 못했어요. 이미 있을 수도 있어요."
fi

echo "⚠️ user1과 user2의 임시 비밀번호를 꼭 바꿔주세요!"

# 3 & 4. '/projectA'라는 특별한 폴더 만들고 권한 설정하기
# 권한 770은 이런 뜻이에요:
# - 폴더 주인 (기본적으로 root)은 읽고, 쓰고, 실행할 수 있어요 (7)
# - 'projectA' 그룹 멤버들도 읽고, 쓰고, 실행할 수 있어요 (7)
# - 다른 사람들은 아무것도 할 수 없어요 (0) -> 외부인 접근 불가!
echo "3 & 4단계: '/projectA' 폴더를 만들고 권한을 770으로 설정하고 있어요..."
sudo mkdir -p /projectA
sudo chown :projectA /projectA
sudo chmod 770 /projectA

# 폴더와 권한이 잘 설정되었는지 확인!
if [ $? -eq 0 ]; then
    echo "✅ '/projectA' 폴더가 만들어지고 권한이 770으로 설정되었어요. 외부인은 못 들어와요!"
else
    echo "❌ '/projectA' 폴더를 만들거나 권한을 설정하지 못했어요."
fi

echo "🎉 설정 완료!"

# 5. 'id'랑 'ls -l' 명령어로 잘 됐는지 확인하기
echo "5단계: 설정이 잘 됐는지 확인해볼까요?"

echo "'user1'이 어떤 그룹에 속해있는지 확인:"
id user1

echo "'user2'가 어떤 그룹에 속해있는지 확인:"
id user2

echo "'/projectA' 폴더의 권한 확인:"
ls -ld /projectA

echo "\n-------------------------------------------------------------------"
echo "숙제 스크립트 끝!"
echo "이 스크립트를 터미널에 복사해서 붙여넣거나 직접 실행할 수 있어요."
echo "실행한 다음에는 user1과 user2의 임시 비밀번호를 꼭 바꿔주세요!"
echo "-------------------------------------------------------------------"
