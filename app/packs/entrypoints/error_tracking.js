import * as Sentry from "@sentry/browser";
import { Integrations } from "@sentry/tracing";

Sentry.init({
  dsn: window.SENTRY_FRONTEND_DSN,
  environment: process.env.NODE_ENV,
  integrations: [new Integrations.BrowserTracing()],
  tracesSampleRate: 0.2,
});
