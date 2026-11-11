import type { Config } from 'tailwindcss';

const config: Config = {
  content: ['./src/**/*.{ts,tsx}'],
  theme: {
    extend: {
      colors: {
        navy: '#28264b',
        mist: '#E8EAE7',
        crimson: '#A40033',
        peri: '#959EC9',
        slate: '#4E5174',
        rose: '#EFDEE9',
        lilac: '#C5C2D1',
        panel: '#BEBDCC',
        card: '#ECEAF8',
      },
      fontFamily: {
        sans: ['"Montserrat Variable"', 'system-ui', 'sans-serif'],
      },
    },
  },
  plugins: [],
};
export default config;

