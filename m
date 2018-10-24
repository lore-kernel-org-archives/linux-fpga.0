Date: Wed, 24 Oct 2018 10:51:35 +0100
From: Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH] fpga: altera_cvp: restrict registration to CvP enabled
 devices
Message-ID: <20181024095135.GA1382@archbook>
References: <78c44ad0b2344a4490ffd300cf0df746@SRV177.busymouse24.de>
 <20181023182649.047f1f93@crub>
 <3773264cdfcb4c258cc7eebd213302dd@SRV177.busymouse24.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3773264cdfcb4c258cc7eebd213302dd@SRV177.busymouse24.de>
To: Andreas Puhm <puhm@oregano.at>
Cc: Anatolij Gustschin <agust@denx.de>, Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, matthew.gerlach@linux.intel.com
List-ID: <linux-fpga@vger.kernel.org>

Hi Anatolij, Andreas,

On Tue, Oct 23, 2018 at 06:46:47PM +0000, Andreas Puhm wrote:
> Hi Anatolij,
> 
> > The CvP docs says that on some FPGAs (e.g. Arria 10) the assertion of CVP
> > status can take up to 500ms. However it is not clear whether this delay
> > might be required after peripheral image configuration and after PCIe
> > link activation. The diagram describing configuration sequence suggests
> > that CVP_EN should be polled until it is asserted. I can imaging the
> > situation that this bit is still not asserted when the device is being
> > probed. Maybe we should better defer device probing if CVP_EN bit is
> > cleared? When deferred probing fails again and sufficient period for
> > CVP_EN bit assertion elapsed, then stop deferred probing and return
> > -ENODEV?
> > 
> > Thanks,
> > 
> > Anatolij
> 
> Anatolij, thank you for your feedback.
> 
> My rationale behind the patch is as follows:
> 
> The CVP_EN is part of the Hard PCIe IP core configuration,
> and therefore, has a defined and static value right from "the start".
> 
> Remark in [1, fig 12]
> " For high density devices such as Intel Cyclone 10 GX, 
> it may be necessary to wait up to 500 ms for the CvP
> status register bit assertion."
> According to [2] the Cyclone 10 GX devices achieve proper operation
> within 100 ms (via the PCIe IP core and CvP).
> 
> I think (and here the documentation is a bit lacking), 
> that this remark is valid only for other bits of the status register,
> e.g., CVP_CONFIG_DONE or USERMODE.
> I also think, that the 500 ms delay is calculated from peripheral + core image programming
> and that the time for peripheral image programming is far lower than that 
> (i.e., low enough to allow PCI enumeration).
> 
> But if this actually means that it can take up to 500 ms to program the peripheral image, 
> than such FPGAs would have different problems.
> I.e., missing the deadline for PCI enumeration. 
> This would need a solution outside of the scope of the
> altera_cvp module (e.g., soft-reset to re-start enumeration with a stable system).
> 
> Bottom line: 
> The CVP_EN should be deemed stable when altera_cvp is called, 
> if not, 
> the programming of the Intel/Altera FPGA and PCIe IP core has not been completed in time
> for the enumeration of the PCI device. Hence it would be questionable or, more likely, would not
> have completed successfully in the first place, i.e., altera_cvp would not have been called.

Yeah I think this makes sense. If your config space isn't up on boot you
would run into issues. I agree the docs are soemwhat vague here. Maybe Matthew or Alan can shoot
an email to their HW folks internally to clarify?

Thanks,
Moritz
