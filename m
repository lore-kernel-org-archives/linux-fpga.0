Date: Wed, 24 Jul 2019 10:05:51 -0700
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCHv2 2/3] fpga: altera-cvp: Preparation for V2 parts.
Message-ID: <20190724170549.GA26502@archbox>
References: <1563317287-18834-1-git-send-email-thor.thayer@linux.intel.com>
 <1563317287-18834-3-git-send-email-thor.thayer@linux.intel.com>
 <20190722005938.GB2583@archbook>
 <6e54c0ee-b8ec-4f95-cf81-70aacc82c72e@linux.intel.com>
 <20190724145704.GB24455@archbox>
 <b52ea6f3-a547-ebce-88f5-6256501a7e99@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b52ea6f3-a547-ebce-88f5-6256501a7e99@linux.intel.com>
To: Thor Thayer <thor.thayer@linux.intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, richard.gong@linux.intel.com, agust@denx.de, linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-fpga@vger.kernel.org>

Hi Thor,

On Wed, Jul 24, 2019 at 11:59:12AM -0500, Thor Thayer wrote:
> Hi Moritz,
> 
> On 7/24/19 9:57 AM, Moritz Fischer wrote:
> > On Tue, Jul 23, 2019 at 09:40:51AM -0500, Thor Thayer wrote:
> > > Hi Moritz,
> > > 
> > > On 7/21/19 7:59 PM, Moritz Fischer wrote:
> > > > Thor,
> > > > 
> > > > On Tue, Jul 16, 2019 at 05:48:06PM -0500, thor.thayer@linux.intel.com wrote:
> > > > > From: Thor Thayer <thor.thayer@linux.intel.com>
> > > > > 
> > > > > In preparation for adding newer V2 parts that use a FIFO,
> > > > > reorganize altera_cvp_chk_error() and change the write
> > > > > function to block based.
> > > > > V2 parts have a block size matching the FIFO while older
> > > > > V1 parts write a 32 bit word at a time.
> > > > > 
> > > > > Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> > > > > ---
> > > > > v2 Remove inline function declaration
> > > > >      Reverse Christmas Tree format for local variables
> > > > > ---
> > > > >    drivers/fpga/altera-cvp.c | 72 ++++++++++++++++++++++++++++++-----------------
> > > > >    1 file changed, 46 insertions(+), 26 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> > > > > index b78c90580071..37419d6b9915 100644
> > > > > --- a/drivers/fpga/altera-cvp.c
> > > > > +++ b/drivers/fpga/altera-cvp.c
> > > > > @@ -140,6 +140,41 @@ static int altera_cvp_wait_status(struct altera_cvp_conf *conf, u32 status_mask,
> > > > >    	return -ETIMEDOUT;
> > > > >    }
> > > > > +static int altera_cvp_chk_error(struct fpga_manager *mgr, size_t bytes)
> > > > > +{
> > > > > +	struct altera_cvp_conf *conf = mgr->priv;
> > > > > +	u32 val;
> > > > > +
> > > > > +	/* STEP 10 (optional) - check CVP_CONFIG_ERROR flag */
> > > > > +	altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
> > > > Same as in the other email, why can we ignore return values here. I
> > > > think the original code probably did that already.
> > > 
> > > Yes, I actually didn't make any changes to this function. You can see I
> > > moved it from below since it is used in the following function.
> > > 
> > > I'm not checking the return code from any of the read/write functions since
> > > the original driver didn't. Would you prefer I check and issue a warning?
> > 
> > Not sure a warning would change much here. We should probably look at
> > why it was ok in the first place.
> 
> A quick grep of the drivers directory shows that an overwhelming majority of
> pci_read_config_dword() and pci_write_config_dword() calls do not check the
> return code.

Yeah I came to the same conclusion after looking around the codebase.

> 
> For robustness, I agree with you that checking and returning the return code
> in this error checking function is important. I will return the error code
> if the read fails.

Ok.

> 
> It shouldn't be necessary to change the rest of the code though unless you
> feel strongly about updating the existing codebase.

Yeah not in this patchset. We'll look at it separately.

Cheers,
Moritz
