// Entry point for the build script in your package.json
// import "./flower";
import "@hotwired/turbo-rails"
import "./controllers"
import "@fortawesome/fontawesome-free/js/all";
Turbo.session.drive = false

console.log("JavaScript file loaded!");
document.addEventListener('DOMContentLoaded', () => {
  const convertButton = document.getElementById('convertButton');
  if (!convertButton) return;
  console.log("Convert Button:", convertButton);
  const form = convertButton.closest('form');
  console.log("Closest Form:", form);
  const animationArea = document.getElementById('animationArea');
  const inputArea = document.querySelector('.input-area');
  console.log("Input Area:", inputArea);

  convertButton.addEventListener('click', (event) => {
    console.log("Button clicked!");
    // デフォルトのフォーム送信をキャンセル
    event.preventDefault();

    inputArea.classList.add('hidden');

    // GIFアニメーションを表示
    animationArea.classList.remove('hidden');

    // 例として5秒後にフォームを送信
    setTimeout(() => {
      form.submit();
    }, 5000); // 5000ミリ秒 = 5秒
  });
});
