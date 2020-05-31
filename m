Date: Sun, 31 May 2020 12:49:29 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCHv2] fpga: stratix10-soc: remove the pre-set
 reconfiguration condition
Message-ID: <20200531194927.GA1622@epycbox.lan>
References: <1589553303-7341-1-git-send-email-richard.gong@linux.intel.com>
 <1d9b21df-7421-b25e-5139-f297e24d99d4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d9b21df-7421-b25e-5139-f297e24d99d4@linux.intel.com>
To: Richard Gong <richard.gong@linux.intel.com>
Cc: mdf@kernel.org, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, dinguyen@kernel.org, Richard Gong <richard.gong@intel.com>
List-ID: <linux-fpga@vger.kernel.org>

On Fri, May 29, 2020 at 08:15:15AM -0500, Richard Gong wrote:
> Hi Moritz,
> 
> Sorry for asking.
> 
> When you get chance, can you review my version 2 patch submitted on
> 05/15/20?
> 
> Regards,
> Richard
> 
> On 5/15/20 9:35 AM, richard.gong@linux.intel.com wrote:
> > From: Richard Gong <richard.gong@intel.com>
> > 
> > The reconfiguration mode is pre-set by driver as the full reconfiguration.
> > As a result, user have to change code and recompile the drivers if he or
> > she wants to perform a partial reconfiguration. Removing the pre-set
> > reconfiguration condition so that user can select full or partial
> > reconfiguration via overlay device tree without recompiling the drivers.

Can you help me understand? See comment below, I'm not sure how this
change changes the behavior.
> > 
> > Also add an error message if the configuration request is failure.
> > 
> > Signed-off-by: Richard Gong <richard.gong@intel.com>
> > ---
> > v2: define and use constant values
> > ---
> >   drivers/fpga/stratix10-soc.c | 9 +++++++--
> >   1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> > index 44b7c56..4d52a80 100644
> > --- a/drivers/fpga/stratix10-soc.c
> > +++ b/drivers/fpga/stratix10-soc.c
> > @@ -14,9 +14,13 @@
> >   /*
> >    * FPGA programming requires a higher level of privilege (EL3), per the SoC
> >    * design.
> > + * SoC firmware supports full and partial reconfiguration.
Consider:
"The SoC firmware supports full and partial reconfiguration."
> >    */
> >   #define NUM_SVC_BUFS	4
> >   #define SVC_BUF_SIZE	SZ_512K
> > +#define FULL_RECONFIG_FLAG	0
> > +#define PARTIAL_RECONFIG_FLAG	1
> > +
> >   /* Indicates buffer is in use if set */
> >   #define SVC_BUF_LOCK	0
> > @@ -182,12 +186,12 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
> >   	uint i;
> >   	int ret;
> > -	ctype.flags = 0;
> >   	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
> >   		dev_dbg(dev, "Requesting partial reconfiguration.\n");
> > -		ctype.flags |= BIT(COMMAND_RECONFIG_FLAG_PARTIAL);
> > +		ctype.flags = PARTIAL_RECONFIG_FLAG;
> >   	} else {
> >   		dev_dbg(dev, "Requesting full reconfiguration.\n");
> > +		ctype.flags = FULL_RECONFIG_FLAG;
> >   	}
Am I missing something here: Doesn't this do the same as before?

Before:
If info->flags & FPGA_MGR_PARTIAL_RECONFIG -> ctype.flags = 0 |
BIT(COMMAND_RECONFIG_FLAG_PARTIAL) -> 1
and ctype->flags = FULL_RECONFIG -> 0 else.

Now:
If info->flags & FPGA_MGR_PARTIAL_RECONFIG -> ctype.flags = PARTIAL_RECONFIG_FLAG -> 1
ctype->flags = FULL_REECONFIG_FLAG -> 0 else.

Am I missing something here? If I don't set the flag for partial
reconfig I'd end up with full reconfiguration in both cases?
If I do set the flag, I get partial reconfiguration in both cases?

> >   	reinit_completion(&priv->status_return_completion);
> > @@ -210,6 +214,7 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
> >   	ret = 0;
> >   	if (!test_and_clear_bit(SVC_STATUS_OK, &priv->status)) {
> > +		dev_err(dev, "RECONFIG_REQUEST failed\n");
> >   		ret = -ETIMEDOUT;
> >   		goto init_done;
> >   	}
> > 

Thanks,
Moritz
