<template>
  <div>
    <p v-if="loading">Loading...</p>
    <ul v-else>
      <article-item v-for="article in articles" :key="article.id" :article="article" />
    </ul>
  </div>
</template>

<script>
  import axios from 'axios'
  import ArticleItem from './ArticleItem'

  export default {
    name: 'NewArticleList',
    components: {
      ArticleItem
    },
    data() {
      return {
        loading: true,
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
        const articles = response.data.map(data => {
          const description = data.excerpt.rendered.replace(/<("[^"]*"|'[^']*'|[^'">])*>/g,'')
          let image = null
          if (
            data['_embedded']['wp:featuredmedia'] &&
            data['_embedded']['wp:featuredmedia'][0] && 
            data['_embedded']['wp:featuredmedia'][0]['media_details'] &&
            data['_embedded']['wp:featuredmedia'][0]['media_details']['sizes'] &&
            data['_embedded']['wp:featuredmedia'][0]['media_details']['sizes']['large']
          ) {
            image = data['_embedded']['wp:featuredmedia'][0]['media_details']['sizes']['large']['source_url']
          }
          return {
            title: data.title.rendered,
            link: data.link,
            description,
            image
          }
        })
        this.$set(this, 'articles', articles)
      })
      .finally(() => {
        this.$set(this, 'loading', false)
      })
    }
  }
</script>
