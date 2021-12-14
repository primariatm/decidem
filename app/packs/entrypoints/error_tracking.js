import * as Sentry from "@sentry/browser";
import { Integrations } from "@sentry/tracing";

Sentry.init({
  dsn: window.SENTRY_DSN,
  environment: "production",
  integrations: [new Integrations.BrowserTracing()],
  tracesSampleRate: 0.2,
});
