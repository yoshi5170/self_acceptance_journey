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
        customBrown: '#B98B73',
        customBeige: '#F0ECE3',
        customGreen2: '#B7B7A4',
        customGreen3: '#d1d1c5',
        customBrown3: '#a98467',
        customBrown2: '#ddb892',
      }
    }
  },
}
