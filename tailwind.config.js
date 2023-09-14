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
      }
    }
  },
}
