require('./bootstrap');
window.Vue = require('vue').default;

import App from './App';
import Vue from 'vue';

const app = new Vue({
    el: '#app',
    render: (h) =>h(App),
});