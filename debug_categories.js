const { getCollection } = require('astro:content');

async function debugCategories() {
  try {
    const posts = await getCollection('blog');
    console.log('Total posts:', posts.length);

    const categoryIssues = [];
    const validCategories = [];

    posts.forEach((p, index) => {
      const category = p.data.category;
      const slug = p.slug;

      if (!category) {
        categoryIssues.push({ index, slug, issue: 'Missing category' });
      } else if (typeof category !== 'string') {
        categoryIssues.push({ index, slug, category, issue: 'Category is not a string' });
      } else if (category.trim() === '') {
        categoryIssues.push({ index, slug, category, issue: 'Empty category string' });
      } else {
        validCategories.push({ index, slug, category });
      }
    });

    console.log('\nCategory issues:', categoryIssues);
    console.log('\nValid categories sample:', validCategories.slice(0, 5));

    if (categoryIssues.length > 0) {
      console.log('\nFirst problematic file:', categoryIssues[0]);
      const problematicPost = posts[categoryIssues[0].index];
      console.log('Full data:', JSON.stringify(problematicPost.data, null, 2));
    }

  } catch (error) {
    console.error('Error:', error);
  }
}

debugCategories();