import * as React from 'react';
import { createRoot } from 'react-dom/client';
import './css/index.css';
import App from './App';
// import './fonts/JuliaMono-Regular.ttf';

const container = document.getElementById('root');
const root = createRoot(container!);
root.render(<React.StrictMode><App /></React.StrictMode>);
