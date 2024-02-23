// 템플릿 코드에는 복잡한 연산을 최대한 줄이는 것이 좋다.
// 템플릿 코드(ejs)는 html로 변환되어 클라이언트(사용자)환경에서 구동되기 때문


// 템플릿 코드 만들기 전에 복잡한 데이터 구조를 사용한다면 UI 코드를 분리하여
// 미리 검증을 할 수 있다.

// SQL 쿼리의 수행 결과도 가상의 데이터 대체하여 시뮬레이션 할 수 있다.
// 그렇다면 내가 작성할 데이터 구조에 더 집중할 수 있다.
// 그렇게 하기 위해서는 조인 쿼리의 결과를 예측하거나 실제 DB에서 입력한 값을
// 디버거에서 카피하여 변수화 할 수 있다.
const queryResult = [
    [1, 1, '첫 번째 댓글입니다.', 'user1', '2024-02-20 10:30', null],
    [2, 2, '첫 번째 댓글의 답글입니다.', 'user2', '2024-02-20 11:00', 1],
    [3, 2, '두 번째 댓글입니다.', 'user2', '2024-02-20 12:00', null],
    [4, 3, '두 번째 댓글의 답글입니다.', 'user3', '2024-02-20 13:00', 3],
    [5, 3, '세 번째 댓글입니다.', 'user3', '2024-02-20 14:00', null]
];

// 댓글과 댓글의 댓글을 구성할 배열
const comments = [];
const commentMap = new Map();

// 댓글과 댓글의 댓글을 구성하는 함수
queryResult.forEach(row => {
    const comment = {
        id: row[0],
        author_id: row[1],
        content: row[2],
        author: row[3],
        created_at: row[4],
        children: [] // 자식 댓글을 저장할 배열
    };

    const parentId = row[5]; // 부모 댓글의 id

    if (parentId === null) {
        // 부모 댓글이 null이면 바로 댓글 배열에 추가
        comments.push(comment);
        commentMap.set(comment.id, comment); // 맵에 추가
    } else {
        // 부모 댓글이 있는 경우 부모 댓글을 찾아서 자식 댓글 배열에 추가
        const parentComment = commentMap.get(parentId);
        parentComment.children.push(comment);
    }
});

// 결과 출력
// console.log(comments);

// 데이터 테이블로 출력
console.table(comments);