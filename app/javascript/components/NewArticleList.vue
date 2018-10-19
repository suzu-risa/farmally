<template>
  <ul>
    <li v-for="article in articles" :key="article.id">
      {{article.title.rendered}}
    </li>
  </ul>
</template>

<script>
  import axios from 'axios'

  export default {
    name: 'NewArticleList',
    data() {
      return {
        articles: []
      }
    },
    created() {
      axios.get('/blog/wp-json/wp/v2/posts', {
        params: {
          _embed: true,
          per_page: 5
        }
      })
      .then(response => {
        console.log(response)
        this.$set(this, 'articles', response.data)
      })
      .catch(error => {
        console.log(error)
      })
    }
  }
</script>
