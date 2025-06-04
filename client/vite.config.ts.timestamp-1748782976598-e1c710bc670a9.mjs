// vite.config.ts
import { defineConfig } from "file:///home/ash/Documents/cashit/node_modules/vite/dist/node/index.js";
import vue from "file:///home/ash/Documents/cashit/node_modules/@vitejs/plugin-vue/dist/index.mjs";
import path from "path";
import AutoImport from "file:///home/ash/Documents/cashit/node_modules/unplugin-auto-import/dist/vite.js";
import Components from "file:///home/ash/Documents/cashit/node_modules/unplugin-vue-components/dist/vite.js";
import {
  UnpluginDirectivesResolver,
  UnpluginModulesResolver,
  UnpluginVueComponentsResolver
} from "file:///home/ash/Documents/cashit/node_modules/maz-ui/resolvers/index.mjs";
var __vite_injected_original_dirname = "/home/ash/Documents/cashit/client";
var proxy = {
  "/auth/login": {
    target: "http://localhost:6589",
    secure: false,
    // rewrite: (path: string) => path.replace(/^\/api/, '\/api/'),
    rewrite: (path2) => path2.replace(/^\/api/, "/"),
    headers: { Connection: "keep-alive" }
  },
  "/auth/session": {
    target: "http://localhost:6589",
    secure: false,
    rewrite: (path2) => path2.replace(/^\/api/, "/"),
    headers: { Connection: "keep-alive" }
  },
  "/auth/google": {
    target: "http://localhost:6589",
    secure: false,
    rewrite: (path2) => path2.replace(/^\/api/, "/"),
    headers: { Connection: "keep-alive" }
  },
  "/auth/register": {
    target: "http://localhost:6589",
    secure: false,
    rewrite: (path2) => path2.replace(/^\/api/, "/"),
    headers: { Connection: "keep-alive" }
  },
  "/api": {
    target: "http://localhost:3000",
    secure: false,
    // rewrite: (path: string) => path.replace(/^\/api/, ''),
    headers: { Connection: "keep-alive" }
  }
  // '/auth': {
  //   target: 'http://localhost:6589',
  //   secure: false,
  //   // rewrite: (path) => path.replace(/^\/auth/, 'auth'),
  //   headers: { Connection: 'keep-alive' },
  // },
  // '/user/connect/ws': { target: 'http://localhost:3001/user/connect/ws', ws: true },
};
var vite_config_default = defineConfig({
  plugins: [
    vue(),
    // vueDevTools({ launchEditor: 'code' }),
    AutoImport({
      imports: [
        "vue",
        "vue-router",
        "pinia",
        "@vueuse/core",
        {
          "@/composables/useDisplay": ["useDisplay"]
        }
      ],
      dts: "src/types/auto/auto-imports.d.ts",
      dirs: ["src/composables", "src/stores"],
      eslintrc: {
        enabled: true,
        globalsPropValue: true
      },
      include: [/\.[tj]sx?$/, /\.vue$/, /\.vue\?vue/]
    }),
    // AppLoading('loading.html'),
    // 自动按需导入组件
    Components({
      dts: "src/types/auto/components.d.ts",
      extensions: ["vue"],
      include: [/\.vue$/, /\.vue\?vue/],
      resolvers: [
        UnpluginVueComponentsResolver(),
        UnpluginDirectivesResolver(),
        UnpluginModulesResolver()
        // RekaResolver(),
        // RekaResolver({
        //   prefix: '' // use the prefix option to add Prefix to the imported components
        // })
      ]
    })
  ],
  resolve: {
    alias: {
      "@": path.resolve(__vite_injected_original_dirname, "./src"),
      // Alias @ to src directory
      "shared/dist": path.resolve(__vite_injected_original_dirname, "../packages/types/dist")
      // Alias for shared types
    }
  },
  build: {
    outDir: "dist",
    // Output directory for production build
    sourcemap: true
    // Generate source maps for debugging
  },
  server: {
    port: 3e3,
    allowedHosts: ["test.cashflowcasino.com", "localhost"],
    proxy
  }
});
export {
  vite_config_default as default
};
//# sourceMappingURL=data:application/json;base64,ewogICJ2ZXJzaW9uIjogMywKICAic291cmNlcyI6IFsidml0ZS5jb25maWcudHMiXSwKICAic291cmNlc0NvbnRlbnQiOiBbImNvbnN0IF9fdml0ZV9pbmplY3RlZF9vcmlnaW5hbF9kaXJuYW1lID0gXCIvaG9tZS9hc2gvRG9jdW1lbnRzL2Nhc2hpdC9jbGllbnRcIjtjb25zdCBfX3ZpdGVfaW5qZWN0ZWRfb3JpZ2luYWxfZmlsZW5hbWUgPSBcIi9ob21lL2FzaC9Eb2N1bWVudHMvY2FzaGl0L2NsaWVudC92aXRlLmNvbmZpZy50c1wiO2NvbnN0IF9fdml0ZV9pbmplY3RlZF9vcmlnaW5hbF9pbXBvcnRfbWV0YV91cmwgPSBcImZpbGU6Ly8vaG9tZS9hc2gvRG9jdW1lbnRzL2Nhc2hpdC9jbGllbnQvdml0ZS5jb25maWcudHNcIjtpbXBvcnQgeyBkZWZpbmVDb25maWcgfSBmcm9tICd2aXRlJ1xuaW1wb3J0IHZ1ZSBmcm9tICdAdml0ZWpzL3BsdWdpbi12dWUnXG5pbXBvcnQgcGF0aCBmcm9tICdwYXRoJ1xuaW1wb3J0IEFwcExvYWRpbmcgZnJvbSAndml0ZS1wbHVnaW4tYXBwLWxvYWRpbmcnXG5pbXBvcnQgQXV0b0ltcG9ydCBmcm9tICd1bnBsdWdpbi1hdXRvLWltcG9ydC92aXRlJ1xuaW1wb3J0IENvbXBvbmVudHMgZnJvbSAndW5wbHVnaW4tdnVlLWNvbXBvbmVudHMvdml0ZSdcbmltcG9ydCB7XG4gIFVucGx1Z2luRGlyZWN0aXZlc1Jlc29sdmVyLFxuICBVbnBsdWdpbk1vZHVsZXNSZXNvbHZlcixcbiAgVW5wbHVnaW5WdWVDb21wb25lbnRzUmVzb2x2ZXIsXG59IGZyb20gJ21hei11aS9yZXNvbHZlcnMnXG5cbmNvbnN0IHByb3h5OiBSZWNvcmQ8c3RyaW5nLCBzdHJpbmcgfCBhbnk+ID0ge1xuICAnL2F1dGgvbG9naW4nOiB7XG4gICAgdGFyZ2V0OiAnaHR0cDovL2xvY2FsaG9zdDo2NTg5JyxcbiAgICBzZWN1cmU6IGZhbHNlLFxuICAgIC8vIHJld3JpdGU6IChwYXRoOiBzdHJpbmcpID0+IHBhdGgucmVwbGFjZSgvXlxcL2FwaS8sICdcXC9hcGkvJyksXG4gICAgcmV3cml0ZTogKHBhdGg6IHN0cmluZykgPT4gcGF0aC5yZXBsYWNlKC9eXFwvYXBpLywgJy8nKSxcblxuICAgIGhlYWRlcnM6IHsgQ29ubmVjdGlvbjogJ2tlZXAtYWxpdmUnIH0sXG4gIH0sXG4gICcvYXV0aC9zZXNzaW9uJzoge1xuICAgIHRhcmdldDogJ2h0dHA6Ly9sb2NhbGhvc3Q6NjU4OScsXG4gICAgc2VjdXJlOiBmYWxzZSxcbiAgICByZXdyaXRlOiAocGF0aDogc3RyaW5nKSA9PiBwYXRoLnJlcGxhY2UoL15cXC9hcGkvLCAnLycpLFxuXG4gICAgaGVhZGVyczogeyBDb25uZWN0aW9uOiAna2VlcC1hbGl2ZScgfSxcbiAgfSxcbiAgJy9hdXRoL2dvb2dsZSc6IHtcbiAgICB0YXJnZXQ6ICdodHRwOi8vbG9jYWxob3N0OjY1ODknLFxuICAgIHNlY3VyZTogZmFsc2UsXG4gICAgcmV3cml0ZTogKHBhdGg6IHN0cmluZykgPT4gcGF0aC5yZXBsYWNlKC9eXFwvYXBpLywgJy8nKSxcblxuICAgIGhlYWRlcnM6IHsgQ29ubmVjdGlvbjogJ2tlZXAtYWxpdmUnIH0sXG4gIH0sXG4gICcvYXV0aC9yZWdpc3Rlcic6IHtcbiAgICB0YXJnZXQ6ICdodHRwOi8vbG9jYWxob3N0OjY1ODknLFxuICAgIHNlY3VyZTogZmFsc2UsXG4gICAgcmV3cml0ZTogKHBhdGg6IHN0cmluZykgPT4gcGF0aC5yZXBsYWNlKC9eXFwvYXBpLywgJy8nKSxcblxuICAgIGhlYWRlcnM6IHsgQ29ubmVjdGlvbjogJ2tlZXAtYWxpdmUnIH0sXG4gIH0sXG4gICcvYXBpJzoge1xuICAgIHRhcmdldDogJ2h0dHA6Ly9sb2NhbGhvc3Q6MzAwMCcsXG4gICAgc2VjdXJlOiBmYWxzZSxcbiAgICAvLyByZXdyaXRlOiAocGF0aDogc3RyaW5nKSA9PiBwYXRoLnJlcGxhY2UoL15cXC9hcGkvLCAnJyksXG4gICAgaGVhZGVyczogeyBDb25uZWN0aW9uOiAna2VlcC1hbGl2ZScgfSxcbiAgfSxcblxuICAvLyAnL2F1dGgnOiB7XG4gIC8vICAgdGFyZ2V0OiAnaHR0cDovL2xvY2FsaG9zdDo2NTg5JyxcbiAgLy8gICBzZWN1cmU6IGZhbHNlLFxuICAvLyAgIC8vIHJld3JpdGU6IChwYXRoKSA9PiBwYXRoLnJlcGxhY2UoL15cXC9hdXRoLywgJ2F1dGgnKSxcbiAgLy8gICBoZWFkZXJzOiB7IENvbm5lY3Rpb246ICdrZWVwLWFsaXZlJyB9LFxuICAvLyB9LFxuICAvLyAnL3VzZXIvY29ubmVjdC93cyc6IHsgdGFyZ2V0OiAnaHR0cDovL2xvY2FsaG9zdDozMDAxL3VzZXIvY29ubmVjdC93cycsIHdzOiB0cnVlIH0sXG59XG5cbi8vIGh0dHBzOi8vdml0ZWpzLmRldi9jb25maWcvXG5leHBvcnQgZGVmYXVsdCBkZWZpbmVDb25maWcoe1xuICBwbHVnaW5zOiBbXG4gICAgdnVlKCksXG4gICAgLy8gdnVlRGV2VG9vbHMoeyBsYXVuY2hFZGl0b3I6ICdjb2RlJyB9KSxcblxuICAgIEF1dG9JbXBvcnQoe1xuICAgICAgaW1wb3J0czogW1xuICAgICAgICAndnVlJyxcbiAgICAgICAgJ3Z1ZS1yb3V0ZXInLFxuICAgICAgICAncGluaWEnLFxuICAgICAgICAnQHZ1ZXVzZS9jb3JlJyxcbiAgICAgICAge1xuICAgICAgICAgICdAL2NvbXBvc2FibGVzL3VzZURpc3BsYXknOiBbJ3VzZURpc3BsYXknXSxcbiAgICAgICAgfSxcbiAgICAgIF0sXG4gICAgICBkdHM6ICdzcmMvdHlwZXMvYXV0by9hdXRvLWltcG9ydHMuZC50cycsXG4gICAgICBkaXJzOiBbJ3NyYy9jb21wb3NhYmxlcycsICdzcmMvc3RvcmVzJ10sXG4gICAgICBlc2xpbnRyYzoge1xuICAgICAgICBlbmFibGVkOiB0cnVlLFxuICAgICAgICBnbG9iYWxzUHJvcFZhbHVlOiB0cnVlLFxuICAgICAgfSxcbiAgICAgIGluY2x1ZGU6IFsvXFwuW3RqXXN4PyQvLCAvXFwudnVlJC8sIC9cXC52dWVcXD92dWUvXSxcbiAgICB9KSxcbiAgICAvLyBBcHBMb2FkaW5nKCdsb2FkaW5nLmh0bWwnKSxcblxuICAgIC8vIFx1ODFFQVx1NTJBOFx1NjMwOVx1OTcwMFx1NUJGQ1x1NTE2NVx1N0VDNFx1NEVGNlxuICAgIENvbXBvbmVudHMoe1xuICAgICAgZHRzOiAnc3JjL3R5cGVzL2F1dG8vY29tcG9uZW50cy5kLnRzJyxcbiAgICAgIGV4dGVuc2lvbnM6IFsndnVlJ10sXG4gICAgICBpbmNsdWRlOiBbL1xcLnZ1ZSQvLCAvXFwudnVlXFw/dnVlL10sXG4gICAgICByZXNvbHZlcnM6IFtcbiAgICAgICAgVW5wbHVnaW5WdWVDb21wb25lbnRzUmVzb2x2ZXIoKSxcbiAgICAgICAgVW5wbHVnaW5EaXJlY3RpdmVzUmVzb2x2ZXIoKSxcbiAgICAgICAgVW5wbHVnaW5Nb2R1bGVzUmVzb2x2ZXIoKSxcbiAgICAgICAgLy8gUmVrYVJlc29sdmVyKCksXG4gICAgICAgIC8vIFJla2FSZXNvbHZlcih7XG4gICAgICAgIC8vICAgcHJlZml4OiAnJyAvLyB1c2UgdGhlIHByZWZpeCBvcHRpb24gdG8gYWRkIFByZWZpeCB0byB0aGUgaW1wb3J0ZWQgY29tcG9uZW50c1xuICAgICAgICAvLyB9KVxuICAgICAgXSxcbiAgICB9KSxcbiAgXSxcbiAgcmVzb2x2ZToge1xuICAgIGFsaWFzOiB7XG4gICAgICAnQCc6IHBhdGgucmVzb2x2ZShfX2Rpcm5hbWUsICcuL3NyYycpLCAvLyBBbGlhcyBAIHRvIHNyYyBkaXJlY3RvcnlcbiAgICAgICdzaGFyZWQvZGlzdCc6IHBhdGgucmVzb2x2ZShfX2Rpcm5hbWUsICcuLi9wYWNrYWdlcy90eXBlcy9kaXN0JyksIC8vIEFsaWFzIGZvciBzaGFyZWQgdHlwZXNcbiAgICB9LFxuICB9LFxuICBidWlsZDoge1xuICAgIG91dERpcjogJ2Rpc3QnLCAvLyBPdXRwdXQgZGlyZWN0b3J5IGZvciBwcm9kdWN0aW9uIGJ1aWxkXG4gICAgc291cmNlbWFwOiB0cnVlLCAvLyBHZW5lcmF0ZSBzb3VyY2UgbWFwcyBmb3IgZGVidWdnaW5nXG4gIH0sXG4gIHNlcnZlcjoge1xuICAgIHBvcnQ6IDMwMDAsXG4gICAgYWxsb3dlZEhvc3RzOiBbJ3Rlc3QuY2FzaGZsb3djYXNpbm8uY29tJywgJ2xvY2FsaG9zdCddLFxuICAgIHByb3h5LFxuICB9LFxufSlcbiJdLAogICJtYXBwaW5ncyI6ICI7QUFBcVIsU0FBUyxvQkFBb0I7QUFDbFQsT0FBTyxTQUFTO0FBQ2hCLE9BQU8sVUFBVTtBQUVqQixPQUFPLGdCQUFnQjtBQUN2QixPQUFPLGdCQUFnQjtBQUN2QjtBQUFBLEVBQ0U7QUFBQSxFQUNBO0FBQUEsRUFDQTtBQUFBLE9BQ0s7QUFWUCxJQUFNLG1DQUFtQztBQVl6QyxJQUFNLFFBQXNDO0FBQUEsRUFDMUMsZUFBZTtBQUFBLElBQ2IsUUFBUTtBQUFBLElBQ1IsUUFBUTtBQUFBO0FBQUEsSUFFUixTQUFTLENBQUNBLFVBQWlCQSxNQUFLLFFBQVEsVUFBVSxHQUFHO0FBQUEsSUFFckQsU0FBUyxFQUFFLFlBQVksYUFBYTtBQUFBLEVBQ3RDO0FBQUEsRUFDQSxpQkFBaUI7QUFBQSxJQUNmLFFBQVE7QUFBQSxJQUNSLFFBQVE7QUFBQSxJQUNSLFNBQVMsQ0FBQ0EsVUFBaUJBLE1BQUssUUFBUSxVQUFVLEdBQUc7QUFBQSxJQUVyRCxTQUFTLEVBQUUsWUFBWSxhQUFhO0FBQUEsRUFDdEM7QUFBQSxFQUNBLGdCQUFnQjtBQUFBLElBQ2QsUUFBUTtBQUFBLElBQ1IsUUFBUTtBQUFBLElBQ1IsU0FBUyxDQUFDQSxVQUFpQkEsTUFBSyxRQUFRLFVBQVUsR0FBRztBQUFBLElBRXJELFNBQVMsRUFBRSxZQUFZLGFBQWE7QUFBQSxFQUN0QztBQUFBLEVBQ0Esa0JBQWtCO0FBQUEsSUFDaEIsUUFBUTtBQUFBLElBQ1IsUUFBUTtBQUFBLElBQ1IsU0FBUyxDQUFDQSxVQUFpQkEsTUFBSyxRQUFRLFVBQVUsR0FBRztBQUFBLElBRXJELFNBQVMsRUFBRSxZQUFZLGFBQWE7QUFBQSxFQUN0QztBQUFBLEVBQ0EsUUFBUTtBQUFBLElBQ04sUUFBUTtBQUFBLElBQ1IsUUFBUTtBQUFBO0FBQUEsSUFFUixTQUFTLEVBQUUsWUFBWSxhQUFhO0FBQUEsRUFDdEM7QUFBQTtBQUFBO0FBQUE7QUFBQTtBQUFBO0FBQUE7QUFBQTtBQVNGO0FBR0EsSUFBTyxzQkFBUSxhQUFhO0FBQUEsRUFDMUIsU0FBUztBQUFBLElBQ1AsSUFBSTtBQUFBO0FBQUEsSUFHSixXQUFXO0FBQUEsTUFDVCxTQUFTO0FBQUEsUUFDUDtBQUFBLFFBQ0E7QUFBQSxRQUNBO0FBQUEsUUFDQTtBQUFBLFFBQ0E7QUFBQSxVQUNFLDRCQUE0QixDQUFDLFlBQVk7QUFBQSxRQUMzQztBQUFBLE1BQ0Y7QUFBQSxNQUNBLEtBQUs7QUFBQSxNQUNMLE1BQU0sQ0FBQyxtQkFBbUIsWUFBWTtBQUFBLE1BQ3RDLFVBQVU7QUFBQSxRQUNSLFNBQVM7QUFBQSxRQUNULGtCQUFrQjtBQUFBLE1BQ3BCO0FBQUEsTUFDQSxTQUFTLENBQUMsY0FBYyxVQUFVLFlBQVk7QUFBQSxJQUNoRCxDQUFDO0FBQUE7QUFBQTtBQUFBLElBSUQsV0FBVztBQUFBLE1BQ1QsS0FBSztBQUFBLE1BQ0wsWUFBWSxDQUFDLEtBQUs7QUFBQSxNQUNsQixTQUFTLENBQUMsVUFBVSxZQUFZO0FBQUEsTUFDaEMsV0FBVztBQUFBLFFBQ1QsOEJBQThCO0FBQUEsUUFDOUIsMkJBQTJCO0FBQUEsUUFDM0Isd0JBQXdCO0FBQUE7QUFBQTtBQUFBO0FBQUE7QUFBQSxNQUsxQjtBQUFBLElBQ0YsQ0FBQztBQUFBLEVBQ0g7QUFBQSxFQUNBLFNBQVM7QUFBQSxJQUNQLE9BQU87QUFBQSxNQUNMLEtBQUssS0FBSyxRQUFRLGtDQUFXLE9BQU87QUFBQTtBQUFBLE1BQ3BDLGVBQWUsS0FBSyxRQUFRLGtDQUFXLHdCQUF3QjtBQUFBO0FBQUEsSUFDakU7QUFBQSxFQUNGO0FBQUEsRUFDQSxPQUFPO0FBQUEsSUFDTCxRQUFRO0FBQUE7QUFBQSxJQUNSLFdBQVc7QUFBQTtBQUFBLEVBQ2I7QUFBQSxFQUNBLFFBQVE7QUFBQSxJQUNOLE1BQU07QUFBQSxJQUNOLGNBQWMsQ0FBQywyQkFBMkIsV0FBVztBQUFBLElBQ3JEO0FBQUEsRUFDRjtBQUNGLENBQUM7IiwKICAibmFtZXMiOiBbInBhdGgiXQp9Cg==
