'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"icons/Icon-maskable-512.png": "d75adc039b0a072942cf706554e405f7",
"icons/Icon-512.png": "d75adc039b0a072942cf706554e405f7",
"icons/Icon-maskable-192.png": "c048d4dab179c7151158db63c40ac5f5",
"icons/Icon-192.png": "c048d4dab179c7151158db63c40ac5f5",
"flutter_bootstrap.js": "f9b4066fe487288c42a67d6a6b0f979e",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.js": "ba4a8ae1a65ff3ad81c6818fd47e348b",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.js": "6cfe36b4647fbfa15683e09e7dd366bc",
"main.dart.js": "5f476c57ecdfd89325fa27492c864cab",
"version.json": "c59ceb0e139532041e50de0347feec10",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "b93248a553f9e8bc17f1065929d5934b",
"assets/packages/iconsax/lib/assets/fonts/iconsax.ttf": "071d77779414a409552e0584dcbfd03d",
"assets/packages/syncfusion_flutter_datagrid/assets/font/UnsortIcon.ttf": "6d8ab59254a120b76bf53f167e809470",
"assets/packages/syncfusion_flutter_datagrid/assets/font/FilterIcon.ttf": "c17d858d09fb1c596ef0adbf08872086",
"assets/FontManifest.json": "68a2433a7a31c952a7a24f6c3574651a",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.json": "3de66e211758557fd68b52fa9d7fd312",
"assets/assets/Group.png": "d77e722edea9928d808656386b2df9a5",
"assets/assets/Overlay/Asset%25205.png": "25ddaca9591411e4ef3db39f5f60d15a",
"assets/assets/Overlay/Asset%252018.png": "36061bd18601949f32adfa8b1c2ddd5a",
"assets/assets/Overlay/Asset%25208.png": "1be35feaddce8e58b0380de7e83e6db9",
"assets/assets/Overlay/Asset%252010.png": "cf1ad478902dbecfc4a2b3d512d82335",
"assets/assets/Overlay/Asset%25201.png": "f2ab54731effd4da5c104722a7851aa4",
"assets/assets/Overlay/Asset%252011.png": "46f6b304a63193ff7228dff3ac8804dd",
"assets/assets/Overlay/Asset%252016.png": "349234798cab1a842f4970173098d916",
"assets/assets/Overlay/Asset%252014.png": "cb675e6ca7b7f2f83530e4a29841f23b",
"assets/assets/Overlay/Asset%25203.png": "dd5fe2b30d44e0af9f48c981a6f8291b",
"assets/assets/Overlay/Asset%25204.png": "8aef18db868b7a9255266ec8cf498583",
"assets/assets/Overlay/Asset%25207.png": "51c3195c874786878fef4b464d3b9710",
"assets/assets/Overlay/Asset%25209.png": "ec587f94dd4a72f56a6d00fc71a0a75c",
"assets/assets/Overlay/Asset%252015.png": "c3977785d44c41e8747eaf84bfaf936d",
"assets/assets/Overlay/Asset%252013.png": "ccc43fc485def9a72f9fd8691b287210",
"assets/assets/Overlay/Asset%252017.png": "db0ecf6351f65b92efc9ab372216fbe2",
"assets/assets/Overlay/Asset%25206.png": "0cce58c6acbdf660e2e6abe9d70a1e8d",
"assets/assets/Overlay/Asset%25202.png": "4c46401764be14d9f18ba33a2e689edc",
"assets/assets/Overlay/Asset%252012.png": "ae5b65275a91a0dfb38a809137eb6a16",
"assets/assets/HMIR3.png": "3dc8812695d47f98a5be3d2a72f2e9b7",
"assets/assets/Branding.png": "e8cf5cb45132e8c29a0ee9adbdd74fcc",
"assets/assets/sample.png": "860e2f52796a6b2964c9fa726fd769df",
"assets/assets/HMIR.png": "8e192440c57392a18b3e8dbd781d2619",
"assets/assets/HMIR2.png": "ed67856e7ad7e55002dc22375050e1ae",
"assets/NOTICES": "ff932688ab4834e9c507b1b68278fa1f",
"assets/AssetManifest.bin": "69ab3187c328abc7ce29ae61b1352463",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/AssetManifest.bin.json": "3f2e77409a00292ef13d4a8f43d8cb50",
"favicon.png": "df3602adfa4aa2721e25462de59f81cc",
"index.html": "fbad3bc47f2397e2dd81b2d0c133e3ce",
"/": "fbad3bc47f2397e2dd81b2d0c133e3ce",
"manifest.json": "0e9aba4eb8a5c49221700ea80a28236e",
"flutter.js": "76f08d47ff9f5715220992f993002504"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
