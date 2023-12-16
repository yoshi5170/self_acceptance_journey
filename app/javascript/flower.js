document.addEventListener('DOMContentLoaded', () => {
  console.log("JavaScript file loaded!");

  // 初めのボタンのイベントリスナー
  const convertButton = document.getElementById('convertButton');
  if (convertButton) {
    const form = convertButton.closest('form');
    const animationArea = document.getElementById('animationArea');
    const inputArea = document.querySelector('.input-area');

    convertButton.addEventListener('click', (event) => {
      event.preventDefault();
      inputArea.classList.add('hidden');
      animationArea.classList.remove('hidden');
      setTimeout(() => {
        form.submit();
      }, 5000);
    });
  }

  // 2番目のボタンのイベントリスナー
  const Button2 = document.getElementById('convertButton2');
  if (Button2) {
    const form2 = Button2.closest('form');
    const animation2 = document.getElementById('animationArea2');
    const inputArea2 = document.querySelector('.input-area');

    Button2.addEventListener('click', (event) => {
      event.preventDefault();
      inputArea2.classList.add('hidden');
      animation2.classList.remove('hidden');
      setTimeout(() => {
        form2.submit();
      }, 5000);
    });
  }

  console.log("イベントリスナーが設定されました");
});
