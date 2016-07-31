window.onload = function() {
    var LEVEL_URL = 'http://153.127.202.15:4567/level/[R]'
    
new Vue( {
    el: '#app',
    data: {
	message: 'Hello!',
	books: [ {tittle: '鍵', auther: '谷崎潤一郎', gage: '80', url: 'http://www.aozora.gr.jp/cards/001383/files/56846_58899.html'} ]
    },
    computed: {
	hasBooks: function(){
	    return this.books.length > 0 ? true : false;
	}
    },
    methods: {
	fetchData: function(level) {
	    var xhr = new XMLHttpRequest();
	    var self = this;
	    xhr.open('GET', LEVEL_URL.replace("[R]", level))
	    xhr.onload = function() {
		self.books = JSON.parse(xhr.responseText)
	    }
	    xhr.send()
	}
    }
})
}
