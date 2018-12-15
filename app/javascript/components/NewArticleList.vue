<template>
  <div>
    <p v-if="loading">Loading...</p>
    <p v-else-if="error">読み込めませんでした</p>
    <div class="article-list columns is-multiline" v-else>
      <article-item v-for="article in articles" :key="article.id" :article="article" />
    </div>
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
        error: false,
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
          const description = data.content.rendered.replace(/<("[^"]*"|'[^']*'|[^'">])*>/g,'')
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
        this.$set(this, 'loading', false)
      })
      .catch(error => {
        this.$set(this, 'error', true)
        this.$set(this, 'loading', false)
      })
    }
  }
</script>
