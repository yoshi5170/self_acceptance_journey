console.log("JavaScript file loaded!");
document.addEventListener('DOMContentLoaded', () => {
  console.log("JavaScript");
  const convertButton = document.getElementById('convertButton');
  if (!convertButton) return;
  const form = convertButton.closest('form');
  const animationArea = document.getElementById('animationArea');
  const inputArea = document.querySelector('.input-area');

  convertButton.addEventListener('click', (event) => {
    // デフォルトのフォーム送信をキャンセル
    event.preventDefault();

    inputArea.classList.add('hidden');

    // GIFアニメーションを表示
    animationArea.classList.remove('hidden');

    // 5秒後にフォームを送信
    setTimeout(() => {
      form.submit();
    }, 10000); // 5秒
  });
});