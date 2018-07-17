Return-Path: <atull@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAJYdmeNSOydws+a=QBG93FHq+3WFzcBR=R_+dM_0Vb_v2zHCvA@mail.gmail.com>
References: <1530629215-26990-1-git-send-email-richard.gong@linux.intel.com>
 <1530629215-26990-7-git-send-email-richard.gong@linux.intel.com> <CAJYdmeNSOydws+a=QBG93FHq+3WFzcBR=R_+dM_0Vb_v2zHCvA@mail.gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Tue, 17 Jul 2018 12:50:34 -0500
Message-ID: <CANk1AXT5DrJf_-dq1DxrGVB23t74+os_F37GFd_i3yY=TgT6CA@mail.gmail.com>
Subject: Re: [PATCHv6 6/8] fpga: add intel stratix10 soc fpga manager driver
Content-Type: text/plain; charset="UTF-8"
To: Moritz Fischer <moritz.fischer.private@gmail.com>
Cc: Richard Gong <richard.gong@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dinh Nguyen <dinguyen@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Devicetree List <devicetree@vger.kernel.org>, linux-fpga@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Yves Vandervennet <yves.vandervennet@linux.intel.com>, Richard Gong <richard.gong@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Mon, Jul 9, 2018 at 6:05 PM, Moritz Fischer
<moritz.fischer.private@gmail.com> wrote:
> Hi Richard + Alan,
>
> couple of small stuff inline. Sorry for the super late reply.
>

Hi Moritz,

Thanks for the review comments!

> On Tue, Jul 3, 2018 at 7:46 AM,  <richard.gong@linux.intel.com> wrote:
>> From: Alan Tull <atull@kernel.org>
>>
>> Add driver for reconfiguring Intel Stratix10 SoC FPGA devices.
>> This driver communicates through the Intel Service Driver which
>> does communication with privileged hardware (that does the
>> FPGA programming) through a secure mailbox.
>>
>> Signed-off-by: Alan Tull <atull@kernel.org>
>> Signed-off-by: Richard Gong <richard.gong@intel.com>
...
>> +static int s10_svc_send_msg(struct s10_priv *priv,
>> +                           enum stratix10_svc_command_code command,
>> +                           void *payload, u32 payload_length)
>> +{
>> +       struct stratix10_svc_chan *chan = priv->chan;
>> +       struct stratix10_svc_client_msg msg;
>> +       int ret;
>> +
>> +       pr_debug("%s cmd=%d payload=%p legnth=%d\n",
>> +                __func__, command, payload, payload_length);
>
> Can we make those dev_dbg() ? Or do we not have a device available?

It's easy to get client dev:and it's worth doing by adding:

struct device *dev = priv->client.dev;

>> +
>> +       msg.command = command;
>> +       msg.payload = payload;
>> +       msg.payload_length = payload_length;
>> +
>> +       ret = stratix10_svc_send(chan, &msg);
>> +       pr_debug("stratix10_svc_send returned status %d\n", ret);
>> +
>> +       return ret;
>> +}
>> +
...
>> +/**
>> + * s10_ops_write_init
>> + * Prepare for FPGA reconfiguration by requesting partial reconfig and
>> + * allocating buffers from the service layer.
>> + * @mgr: fpga manager
>> + * @info: fpga image info
>> + * @buf: fpga image buffer
>> + * @count: size of buf in bytes
>> + */
>> +static int s10_ops_write_init(struct fpga_manager *mgr,
>> +                             struct fpga_image_info *info,
>> +                             const char *buf, size_t count)
>> +{
>> +       struct s10_priv *priv = mgr->priv;
>> +       struct device *dev = priv->client.dev;
>> +       struct stratix10_svc_command_reconfig_payload payload;
>> +       char *kbuf;
>> +       uint i;
>> +       int ret;
>> +
>> +       payload.flags = 0;
>> +       if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
>> +               dev_info(dev, "Requesting partial reconfiguration.\n");
> Do we need these to be _info() or can the by _dbg()? The Framework
> already prints ("Writing blah.foo to ...")
>> +               payload.flags |= BIT(COMMAND_RECONFIG_FLAG_PARTIAL);
>> +       } else {
>> +               dev_info(dev, "Requesting full reconfiguration.\n");
> Same here.

These can go away or be dgb.  fpga-mgr.c has dev_info(dev, "writing %s
to %s\n", image_name, mgr->name); in fpga_mgr_firmware_load().

Maybe at some point it would be better to have the "Reauesting
full/partial reconfiguration" messages as dbg messages in fpga-mgr.c.
Some of the fpga manager drivers have one message or the other only
because they only handle full or partial, so it's an error message in
their case.such as "Partial reconfiguration not supported."

>> +       }
>> +
>> +       reinit_completion(&priv->status_return_completion);
>> +       ret = s10_svc_send_msg(priv, COMMAND_RECONFIG,
>> +                              &payload, sizeof(payload));
>> +       if (ret < 0)
>> +               goto init_done;
>> +
>> +       ret = wait_for_completion_interruptible_timeout(
>> +               &priv->status_return_completion, S10_RECONFIG_TIMEOUT);
>> +       if (!ret) {
>> +               dev_err(dev, "timeout waiting for RECONFIG_REQUEST\n");
>> +               ret = -ETIMEDOUT;
>> +               goto init_done;
>> +       }
>> +       if (ret < 0) {
>> +               dev_err(dev, "error (%d) waiting for RECONFIG_REQUEST\n", ret);
>> +               goto init_done;
>> +       }
>> +
>> +       ret = 0;
>> +       if (!test_and_clear_bit(SVC_STATUS_RECONFIG_REQUEST_OK,
>> +                               &priv->status)) {
>> +               ret = -ETIMEDOUT;
>> +               goto init_done;
>> +       }
>> +
>> +       /* Allocate buffers from the service layer's pool. */
>> +       for (i = 0; i < NUM_SVC_BUFS; i++) {
>> +               kbuf = stratix10_svc_allocate_memory(priv->chan, SVC_BUF_SIZE);
>> +               if (!kbuf) {
>> +                       s10_free_buffers(mgr);
>> +                       ret = -ENOMEM;
>> +                       goto init_done;
>> +               }
>> +
>> +               priv->svc_bufs[i].buf = kbuf;
>> +               priv->svc_bufs[i].lock = 0;
>> +       }
>> +
>> +init_done:
>> +       stratix10_svc_done(priv->chan);
>> +       return ret;
>> +}
>> +
>> +/**
>> + * s10_send_buf
>> + * Send a buffer to the service layer queue
>> + * @mgr: fpga manager struct
>> + * @buf: fpga image buffer
>> + * @count: size of buf in bytes
>> + * Returns # of bytes transferred or -ENOBUFS if the all the buffers are in use
>> + * or if the service queue is full. Never returns 0.
>> + */
>> +static int s10_send_buf(struct fpga_manager *mgr, const char *buf, size_t count)
>> +{
>> +       struct s10_priv *priv = mgr->priv;
>> +       struct device *dev = priv->client.dev;
>> +       void *svc_buf;
>> +       size_t xfer_sz;
>> +       int ret;
>> +       uint i;
>> +
>> +       /* get/lock a buffer that that's not being used */
>> +       for (i = 0; i < NUM_SVC_BUFS; i++)
>> +               if (!test_and_set_bit_lock(SVC_BUF_LOCK,
>> +                                          &priv->svc_bufs[i].lock))
>> +                       break;
>> +
>> +       if (i == NUM_SVC_BUFS)
>> +               return -ENOBUFS;
>> +
>> +       xfer_sz = count < SVC_BUF_SIZE ? count : SVC_BUF_SIZE;
>> +
>> +       svc_buf = priv->svc_bufs[i].buf;
>> +       memcpy(svc_buf, buf, xfer_sz);
>> +       ret = s10_svc_send_msg(priv, COMMAND_RECONFIG_DATA_SUBMIT,
>> +                              svc_buf, xfer_sz);
>> +       if (ret < 0) {
>> +               dev_err(dev,
>> +                       "Error while sending data to service layer (%d)", ret);
>> +               return ret;
>> +       }
> Do we need to clean up anything here, or is the buffer unlocked if we fail?

Yes, need to unlock buff if s10_svc_send_msg() fails.

                        clear_bit_unlock(SVC_BUF_LOCK,
                                         &priv->svc_bufs[i].lock);

>> +
>> +       return xfer_sz;
>> +}
...
>> +static int s10_probe(struct platform_device *pdev)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       struct s10_priv *priv;
>> +       struct fpga_manager *mgr;
>> +       int ret;
>> +
>> +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +       if (!priv)
>> +               return -ENOMEM;
>> +
>> +       priv->client.dev = dev;
>> +       priv->client.receive_cb = s10_receive_callback;
>> +       priv->client.priv = priv;
>> +
>> +       priv->chan = stratix10_svc_request_channel_byname(&priv->client,
>> +                                               SVC_CLIENT_FPGA);
>> +       if (IS_ERR(priv->chan)) {
>> +               dev_err(dev, "couldn't get service channel (%s)\n",
>> +                       SVC_CLIENT_FPGA);
>> +               return PTR_ERR(priv->chan);
>> +       }
>> +
>> +       init_completion(&priv->status_return_completion);
>> +
>> +       mgr = fpga_mgr_create(dev, "Stratix10 SOC FPGA Manager",
>> +                             &s10_ops, priv);
>> +       if (!mgr)
>> +               return -ENOMEM;
> Does this release the channel above?

We need to call "stratix10_svc_free_channel(priv->chan);" here if
fpga_mgr_create() fails.

>> +
>> +       ret = fpga_mgr_register(mgr);
>> +       if (ret) {
>> +               dev_err(dev, "unable to register FPGA manager\n");
>> +               stratix10_svc_free_channel(priv->chan);
>> +               fpga_mgr_free(mgr);
>> +               return ret;
>> +       }
>> +
>> +       platform_set_drvdata(pdev, mgr);
>> +
>> +       return ret;
>> +}
