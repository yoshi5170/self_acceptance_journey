module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [
    require("daisyui"),
  ],
  theme: {
    extend: {
      colors: {
        customGreen: '#6B705C',
        customGreen2: '#B7B7A4',
        customGreen3: '#c8c8ba',
        customGreen4: '#80866e',
        customGreen5: '#6F7D42',
        customGreen6: '#B6B486',
        customGreen7: '#C0BE97',
        customBrown: '#B98B73',
        customBrown2: '#ddb892',
        customBrown3: '#a98467',
        customBeige: '#F0ECE3',
        customBeige2: '#e2dbc9',
        customBeige3: '#f7f5f0',
        customBeige4: '#dcd3bd',
      }
    }
  },
}
