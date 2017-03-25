-module(prometheus_rabbitmq_exporter_config).

-export([path/0,
         queue_messages_stat/0,
         exchange_messages_stat/0]).

-define(DEFAULT_PATH, "/metrics").
-define(DEFAULT_QUEUE_MESSAGES_STAT, [messages_published_total,
                                      messages_confirmed_total,
                                      messages_delivered_total,
                                      messages_delivered_no_ack_total,
                                      messages_get_total,
                                      messages_get_no_ack_total,
                                      messages_deliver_get_total,
                                      messages_redelivered_total,
                                      messages_returned_total]).
-define(DEFAULT_EXCHANGE_MESSAGES_STAT, [messages_published_total,
                                         messages_published_in_total,
                                         messages_published_out_total,
                                         messages_confirmed_total,
                                         messages_delivered_total,
                                         messages_delivered_no_ack_total,
                                         messages_get_total,
                                         messages_get_no_ack_total,
                                         messages_deliver_get_total,
                                         messages_redelivered_total,
                                         messages_returned_total]).
-define(DEFAULT_CONFIG, [{path, ?DEFAULT_PATH},
                         {queue_messages_stat, ?DEFAULT_QUEUE_MESSAGES_STAT},
                         {exchange_messages_stat, ?DEFAULT_EXCHANGE_MESSAGES_STAT}]).

config() ->
  application:get_env(prometheus, rabbitmq_exporter, ?DEFAULT_CONFIG).

path() ->
  Config = config(),
  proplists:get_value(path, Config, ?DEFAULT_PATH).

queue_messages_stat() ->
  Config = config(),
  proplists:get_value(queue_messages_stat, Config, ?DEFAULT_QUEUE_MESSAGES_STAT).

exchange_messages_stat() ->
  Config = config(),
  proplists:get_value(exchange_messages_stat, Config, ?DEFAULT_EXCHANGE_MESSAGES_STAT).
