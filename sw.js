var CACHE_NAME = "pixyll2-20190210140745";

self.addEventListener("install", function(e) {
  e.waitUntil(
    caches.open(CACHE_NAME).then(function(cache) {
      return cache.addAll([
        "/pixyll/css/pixyll.css?201902101407",
        "/pixyll/"
      ]);
    })
  );
});

self.addEventListener("activate", function(e) {
  e.waitUntil(
    caches.keys().then(function(names) {
      return Promise.all(
        names.map(function(name) {
          if (name != CACHE_NAME) {
            return caches.delete(name);
          }
        })
      );
    })
  );
  return clients.claim();
});

addEventListener("fetch", function(e) {
  e.respondWith(
    caches.match(e.request).then(function(response) {
        return response || fetch(e.request)
    })
  );
});
