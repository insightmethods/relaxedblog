function Page-all_published-map(doc) {
  if(doc.class == "Page" && !!doc.published) {
    emit((doc.created_at||{}), doc);
  }
}

function Page-all_tagged_published-map(doc) {
  if(doc.class == "Page" && !!doc.published) {
    for(tag in doc.tags)
       emit(doc.tags[tag], doc);
  }
}