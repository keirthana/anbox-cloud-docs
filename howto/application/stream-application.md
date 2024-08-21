(howto-stream-applications)=
# How to stream applications

You can stream applications using the Anbox Cloud dashboard or your custom stream client. You can also stream applications by launching an instance with streaming enabled, using the `amc` CLI.

## Using the CLI

If you are using the `amc` CLI, you can use the `--enable-streaming` option at the time of launching the instance:

    amc launch --enable-streaming <application_id>

When the `--enable-streaming` option is specified, the Anbox Management Service (AMS) automatically creates a streaming session for the instance. You can find the id of the session as a tag on the instance in the format `session=<id>`.

To further customise the streaming configuration, use the following arguments:
* `--display-size`
* `--display-density`
* `--fps`

For example, to create an instance with a 1080p resolution, a frame rate of 60 and a DPI of 120, run:

    amc launch --enable-streaming --display-size=1920x1080 --display-density=120 --fps=60 <application_id>

## Using the dashboard

The dashboard has in-browser streaming capabilities through WebRTC. It uses the {ref}`sec-streaming-sdk`.

When creating an instance, make sure you select the *Enable Streaming* capability to be able to stream your application. You can also set the desired streaming attributes using the *Virtual display* options available for an instance.

You can start a streaming session for any of the successfully created applications. Once the associated instance is created and ready, click *Stream* ( ![stream icon](/images/icons/stream-icon.png) ) to start the stream.

To understand how the streaming stack of Anbox Cloud works, see {ref}`exp-application-streaming`.

### Streaming statistics

View the streaming statistics for your running sessions by selecting the **Statistics** button on the session. The statistics display on the right pane and also have a download option to download the statistics in a `.csv` format for further analysis.

The downloaded `.csv` file has the following statistics:

| Statistic | Description |
| --------- |------------ |
| `date` | Date and time in ISO 8601 format |
| `network-currentrtt` | Current round-trip time of the network |
| `video-bandwidth` | The amount of video data that the session can handle per second |
| `video-totalreceived` | Total video data received |
| `video-fps` | Video frames per second |
| `video-decodetime` | Time taken to extract video |
| `video-jitter` | Loss of transmitted video data during streaming |
| `video-averagejitterbufferdelay` | Average jitter buffer delay in video transmission  |
| `video-packetsreceived` | Number of video packets received |
| `video-packetslost` | Number of video packets lost |
| `audio-bandwidth` | The amount of audio data that the session can handle per second |
| `audio-totalreceived` | Total audio data received during streaming |
| `audio-totalsamplesreceived` | Total number of audio samples received |
| `audio-jitter` | Loss of transmitted audio data during streaming |
| `audio-averagejitterbufferdelay` | Average jitter buffer delay in audio transmission |
| `audio-packetsreceived` | Number of audio packets received |
| `audio-packetslost` | Number of audio packets lost |

### Sharing a streaming session

To share your stream with users without an account, click *Set up sharing* ( ![set up sharing icon](/images/icons/share-stream-icon.png) ) on the *Instances* page.

Set your stream title and expiration details and generate a link that can be shared with others.

## Related topics

* {ref}`tut-set-up-stream-client`
* {ref}`howto-access-stream-gateway`
