# Prmoetheus

## Types of monitoring

### PROFILING

Profiling takes the approach that you can’t have all the context for all of the events all of the time, but you can have some of the context for limited periods of time.

Tcpdump is one example of a profiling tool. It allows you to record network traffic based on a specified filter. It’s an essential debugging tool, but you can’t really turn it on all the time as you will run out of disk space.

Debug builds of binaries that track profiling data are another example. They provide a plethora of useful information, but the performance impact of gathering all that information, such as timings of every function call, means that it is not generally practical to run it in production on an ongoing basis.

In the Linux kernel, enhanced Berkeley Packet Filters (eBPF) allow detailed profiling of kernel events from filesystem operations to network oddities. These provide access to a level of insight that was not generally available previously, and I’d recommend reading Brendan Gregg’s writings on the subject.

Profiling is largely for tactical debugging. If it is being used on a longer term basis, then the data volume must be cut down in order to fit into one of the other categories of monitoring.

### TRACING

Tracing doesn’t look at all events, rather it takes some proportion of events such as one in a hundred that pass through some functions of interest. Tracing will note the functions in the stack trace of the points of interest, and often also how long each of these functions took to execute. From this you can get an idea of where your program is spending time and which code paths are most contributing to latency.

Rather than doing snapshots of stack traces at points of interest, some tracing systems trace and record timings of every function call below the function of interest. For example, one in a hundred user HTTP requests might be sampled, and for those requests you could see how much time was spent talking to backends such as databases and caches. This allows you to see how timings differ based on factors like cache hits versus cache misses.

Distributed tracing takes this a step further. It makes tracing work across processes by attaching unique IDs to requests that are passed from one process to another in remote procedure calls (RPCs) in addition to whether this request is one that should be traced. The traces from different processes and machines can be stitched back together based on the request ID. This is a vital tool for debugging distributed microservices architectures. Technologies in this space include OpenZipkin and Jaeger.

For tracing, it is the sampling that keeps the data volumes and instrumentation performance impact within reason.

### LOGGING

Logging looks at a limited set of events and records some of the context for each of these events. For example, it may look at all incoming HTTP requests, or all outgoing database calls. To avoid consuming too much resources, as a rule of thumb you are limited to somewhere around a hundred fields per log entry. Beyond that, bandwidth and storage space tend to become a concern.

For example, for a server handling a thousand requests per second, a log entry with a hundred fields each taking ten bytes works out as a megabyte per second. That’s a nontrivial proportion of a 100 Mbit network card, and 84 GB of storage per day just for logging.

A big benefit of logging is that there is (usually) no sampling of events, so even though there is a limit on the number of fields, it is practical to determine how slow requests are affecting one particular user talking to one particular API endpoint.

Just as monitoring means different things to different people, logging also means different things depending on who you ask, which can cause confusion. Different types of logging have different uses, durability, and retention requirements. As I see it, there are four general and somewhat overlapping categories:

#### types of logs

Transaction logs
These are the critical business records that you must keep safe at all costs, likely forever. Anything touching on money or that is used for critical user-facing features tends to be in this category.

##### Request logs

If you are tracking every HTTP request, or every database call, that’s a request log. They may be processed in order to implement user facing features, or just for internal optimisations. You don’t generally want to lose them, but it’s not the end of the world if some of them go missing.

##### Application logs

Not all logs are about requests; some are about the process itself. Startup messages, background maintenance tasks, and other process-level log lines are typical. These logs are often read directly by a human, so you should try to avoid having more than a few per minute in normal operations.

##### Debug logs

Debug logs tend to be very detailed and thus expensive to create and store. They are often only used in very narrow debugging situations, and are tending towards profiling due to their data volume. Reliability and retention requirements tend to be low, and debug logs may not even leave the machine they are generated on.

Treating the differing types of logs all in the same way can end you up in the worst of all worlds, where you have the data volume of debug logs combined with the extreme reliability requirements of transaction logs. Thus as your system grows you should plan on splitting out the debug logs so that they can be handled separately.

Examples of logging systems include the ELK stack and Graylog.

### METRICS

Metrics largely ignore context, instead tracking aggregations over time of different types of events. To keep resource usage sane, the amount of different numbers being tracked needs to be limited: ten thousand per process is a reasonable upper bound for you to keep in mind.

Examples of the sort of metrics you might have would be the number of times you received HTTP requests, how much time was spent handling requests, and how many requests are currently in progress. By excluding any information about context, the data volumes and processing required are kept reasonable.

That is not to say, though, that context is always ignored. For a HTTP request you could decide to have a metric for each URL path. But the ten thousand metric guideline has to be kept in mind, as each distinct path now counts as a metric. Using context such as a user’s email address would be unwise, as they have an unbounded cardinality.4

You can use metrics to track the latency and data volumes handled by each of the subsystems in your applications, making it easier to determine what exactly is causing a slowdown. Logs could not record that many fields, but once you know which subsystem is to blame, logs can help you figure out which exact user requests are involved.

This is where the tradeoff between logs and metrics becomes most apparent. Metrics allow you to collect information about events from all over your process, but with generally no more than one or two fields of context with bounded cardinality. Logs allow you to collect information about all of one type of event, but can only track a hundred fields of context with unbounded cardinality. This notion of cardinality and the limits it places on metrics is important to understand, and I will come back to it in later chapters.

As a metrics-based monitoring system, Prometheus is designed to track overall system health, behaviour, and performance rather than individual events. Put another way, Prometheus cares that there were 15 requests in the last minute that took 4 seconds to handle, resulted in 40 database calls, 17 cache hits, and 2 purchases by customers. The cost and code paths of the individual calls would be the concern of profiling or logging.

Now that you have an understanding of where Prometheus fits in the overall monitoring space, let’s look at the

## Prometheus

### Gauges

Metrics like process*resident_memory_bytes are called **gauges**. For a gauge, it is its current absolute value that is important to you. There is a second core type of metric called thecounter. Counters track how many events have happened, or the total size ofall the events. Let’s look at a counter by graphingprometheus_tsdb_head*​samples_appended_total, the number of samples Prometheus has ingested, which will look like Figure 2-8.

Counters are always increasing. This creates nice up and to the right graphs, but the values of counters are not much use on their own. What you really want to know is how fast the counter is increasing, which is where the rate function comes in. The rate function calculates how fast a counter is increasing per second. Adjust your expression to **rate(prometheus_tsdb_head_samples_appended_total[1m])**, which will calculate how many samples Prometheus is ingesting per second averaged over one minute and produce a result such as that shown in

### Adding a new node

```yml
global:
  scrape_interval: 10s
scrape_configs:
  - job_name: prometheus
    static_configs:
      - targets:
          - localhost:9090
  - job_name: node # new node
    static_configs:
      - targets:
          - localhost:9100
```

As you add more jobs and scrape configs, it is rare that you will want to look at the same metric from different jobs at the same time. The memory usage of a Prometheus and a Node exporter are very different, for example, and extraneous data make debugging and investigation harder. You can graph the memory usage of just the Node exporters with process_resident_memory_bytes{job="node"}. The job="node" is called a label matcher, and it restricts the metrics that are returned

The process_resident_memory_bytes here is the memory used by the Node exporter process itself (as is hinted by the process prefix) and not the machine as a whole. Knowing the resource usage of the Node exporter is handy and all, but it is not why you run it.

As a final example evaluate rate(node_network_receive_bytes_total[1m]) in Graph view to produce a graph like the one shown in

node_network_receive_bytes_total is a counter for how many bytes have been received by network interfaces. The Node exporter automatically picked up all my network interfaces, and they can be worked with as a group in PromQL. This is useful for alerting, as labels avoid the need to exhaustively list every single thing you wish to alert on.

## Alerting

For alerting rules you need a PromQL expression that returns only the results that you wish to alert on. In this case that is easy to do using the == operator. == will filter8 away any time series whose values don’t match. If you evaluate up == 0 in the expression browser, only the down instance is returned

### Adding alert manager

```yaml
global:
  scrape_interval: 10s
  evaluation_interval: 10s # interval to evaluate the rule to then create alert
rule_files: # specify the rule file for the alert from below
  - rules.yml
alerting:
  alertmanagers: # adding the alert manager on port 9093
    - static_configs:
        - targets:
            - localhost:9093
scrape_configs:
  - job_name: prometheus
    static_configs:
      - targets:
          - localhost:9090
  - job_name: node
    static_configs:
      - targets:
          - localhost:9100
```

### Creating rules.yml for alers

Example 2-2. rules.yml with a single alerting rule

```yml
groups:
  - name: example
    rules:
      - alert: InstanceDown
        expr: up == 0
        for: 1m
```

The InstanceDown alert will be evaluated every 10 seconds in accordance with the evaluation_interval. If a series is continuously returned for at least a minute9 (the for), then the alert will be considered to be firing. Until the required minute is up, the alert will be in a pending state. On the Alerts page you can click this alert and see more detail

Example 2-3. alertmanager.yml sending all alerts to email

```yml
global:
  smtp_smarthost: "localhost:25"
  smtp_from: "youraddress@example.org"
route:
  receiver: example-email
receivers:
  - name: example-email
    email_configs:
      - to: "youraddress@example.org"
```

## Instrumentation

### The Counter

Counters are the type of metric you will probably use in instrumentation most often. Counters track either the number or size of events. They are mainly used to track how often a particular code path is executed.

Extend the above code as shown in Example 3-3 to add a new metric for how many times a Hello World was requested.

There are three parts here: the import, the metric definition, and the instrumentation.

- Import

Python requires that you import functions and classes from other modules in order to use them. Accordingly, you must import the Counter class from the prometheus_client library at the top of the file.

- Definition

Prometheus metrics must be defined before they are used. Here I define a counter called hello_worlds_total. It has a help string of Hello Worlds requested., which will appear on the /metrics page to help you understand what the metric means.

Metrics are automatically registered with the client library in the default registry.1 You do not need to pull the metric back to the start_http_server call; in fact, how the code is instrumented is completely decoupled from the exposition. If you have a transient dependency that includes Prometheus instrumentation, it will appear on your /metrics automatically.

Metrics must have unique names, and client libraries should report an error if you try to register the same metric twice. To avoid this, define your metrics at file level, not at class, function, or method level.

- Instrumentation

Now that you have the metric object defined, you can use it. The inc method increments the counter’s value by one.

Prometheus client libraries take care of all the nitty-gritty details like bookkeeping and thread-safety for you, so that is all there is to it.

When you run the program, the new metric will appear on the /metrics. It will start at zero and increase by one2 every time you view the main URL of the application. You can view this in the expression browser and use the PromQL expression rate(hello_worlds_total[1m]) to see how many Hello World requests are happening per second

### Counting Exceptions

Client libraries provide not just core functionality, but also utilities and methods for common use cases. One of these in Python is the ability to count exceptions. You don’t have to write your own instrumentation using a try…except; instead you can take advantage of the count_exceptions context manager and decorator as shown in

```py
import random
from prometheus_client import Counter

REQUESTS = Counter('hello_worlds_total',
        'Hello Worlds requested.')
EXCEPTIONS = Counter('hello_world_exceptions_total',
        'Exceptions serving Hello World.')

class MyHandler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        REQUESTS.inc()
        with EXCEPTIONS.count_exceptions():
          if random.random() < 0.2:
            raise Exception
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"Hello World")
```

count_exceptions will take care of passing the exception up by raising it, so it does not interfere with application logic. You can see the rate of exceptions with rate(hello_world_exceptions_total[1m]). The number of exceptions isn’t that useful without knowing how many requests are going through. You can calculate the more useful ratio of exceptions with

```
  rate(hello_world_exceptions_total[1m])
/
  rate(hello_worlds_total[1m])
```

in the expression browser. This is how to generally expose ratios: expose two counters, then rate and divide them in PromQL.

```py
You can also use count_exceptions as a function decorator:

EXCEPTIONS = Counter('hello_world_exceptions_total',
        'Exceptions serving Hello World.')

class MyHandler(http.server.BaseHTTPRequestHandler):
    @EXCEPTIONS.count_exceptions()
    def do_GET(self):
      ...
```

### Counting Size

Prometheus uses 64-bit floating-point numbers for values so you are not limited to incrementing counters by one. You can in fact increment counters by any non-negative number. This allows you to track the number of records processed, bytes served, or sales in Euros as shown in Example 3-5.

```py
Example 3-5. SALES tracks sale value in Euros
import random
from prometheus_client import Counter

REQUESTS = Counter('hello_worlds_total',
        'Hello Worlds requested.')
SALES = Counter('hello_world_sales_euro_total',
        'Euros made serving Hello World.')

class MyHandler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        REQUESTS.inc()
        euros = random.random()
        SALES.inc(euros)
        self.send_response(200)
        self.end_headers()
        self.wfile.write("Hello World for {} euros.".format(euros).encode())
```

You can see the rate of sales in Euros per second in the expression browser using the expression rate(hello_world_sales_euro_total[1m]), the same as for integer counters.

### The Gauge

Gauges are a snapshot of some current state. While for counters how fast it is increasing is what you care about, for gauges it is the actual value of the gauge. Accordingly, the values can go both up and down.

Examples of gauges include:

1. the number of items in a queue

2. memory usage of a cache

3. number of active threads

4. the last time a record was processed

5. average requests per second in the last minute3

#### Using Gauges

Gauges have three main methods you can use: inc, dec, and set. Similar to the methods on counters, inc and dec default to changing a gauge’s value by one. You can pass an argument with a different value to change by if you want. Example 3-6 shows how gauges can be used to track the number of calls in progress and determine when the last one was completed.

```py
Example 3-6. INPROGRESS and LAST track the number of calls in progress and when the last one was completed
import time
from prometheus_client import Gauge

INPROGRESS = Gauge('hello_worlds_inprogress',
        'Number of Hello Worlds in progress.')
LAST = Gauge('hello_world_last_time_seconds',
        'The last time a Hello World was served.')

class MyHandler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        INPROGRESS.inc()
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"Hello World")
        LAST.set(time.time())
        INPROGRESS.dec()
```

These metrics can be used directly in the expression browser without any additional functions. For example, hello_world_last_time_seconds can be used to determine when the last Hello World was served. The main use case for such a metric is detecting if it has been too long since a request was handled. The PromQL expression time() - hello_world_last_time_seconds will tell you how many seconds it is since the last request.

These are both very common use cases, so utility functions are also provided for them as you can see in Example 3-7. track*inprogress has the advantage of being both shorter and taking care of correctly handling exceptions for you. set_to*​current_time is a little less useful in Python, as time.time() returns Unix time in seconds;5 but in other languages’ client libraries, the set_to_current_time equivalents make usage simpler and clearer.

```py
Example 3-7. The same example as Example 3-6 but using the gauge utilities
from prometheus_client import Gauge

INPROGRESS = Gauge('hello_worlds_inprogress',
        'Number of Hello Worlds in progress.')
LAST = Gauge('hello_world_last_time_seconds',
        'The last time a Hello World was served.')

class MyHandler(http.server.BaseHTTPRequestHandler):
    @INPROGRESS.track_inprogress()
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"Hello World")
        LAST.set_to_current_time()
```

### METRIC SUFFIXES

You may have noticed that the example counter metrics all ended with \_total, while there is no such suffix on gauges. This is a convention within Prometheus that makes it easier to identify what type of metric you are working with.

In addition to \_total, the \_count, \_sum, and \_bucket suffixes also have other meanings and should not be used as suffixes in your metric names to avoid confusion.

It is also strongly recommended that you include the unit of your metric at the end of its name. For example, a counter for bytes processed might be myapp*requests*​processed_bytes_total.

### Callbacks

To track the size or number of items in a cache, you should generally add inc and dec calls in each function where items are added or removed from the cache. With more complex logic this can get a bit tricky to get right and maintain as the code changes. The good news is that client libraries offer a shortcut to implement this, without having to use the interfaces that writing an exporter require.

In Python, gauges have a set_function method, which allows you to specify a function to be called at exposition time. Your function must return a floating point value for the metric when called, as demonstrated in Example 3-8. However, this strays a bit outside of direct instrumentation, so you will need to consider thread safety and may need to use mutexes.

```py
Example 3-8. A trivial example of set_function to have a metric return the current time6
import time
from prometheus_client import Gauge

TIME = Gauge('time_seconds',
        'The current time.')
TIME.set_function(lambda: time.time())
```
