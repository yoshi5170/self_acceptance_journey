// Entry point for the build script in your package.json
// import "./flower";
import "@hotwired/turbo-rails"
import "./controllers"
import "@fortawesome/fontawesome-free/js/all";
Turbo.session.drive = false

document.addEventListener('DOMContentLoaded', () => {
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
    }, 5000); // 5000ミリ秒 = 5秒
  });
});
