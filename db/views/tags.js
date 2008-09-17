function Tag-all-map(doc) {
    for (var i=0; i<doc.tags.length; i++) {
        emit(doc.tags[i], 1);
    }
}

function Tag-all-reduce(tag, count) {
    var size = 0;
    for (var i=0; i < count.length ;i++){
        size += count[i];
    }
    
    return size;
}