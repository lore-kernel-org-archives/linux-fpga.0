Return-Path: <SRS0=6+9k=BA=vger.kernel.org=linux-fpga-owner@kernel.org>
Return-Path: <SRS0=6+9k=BA=vger.kernel.org=linux-fpga-owner@kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:35784 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbgGUGH5 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 21 Jul 2020 02:07:57 -0400
Date: Tue, 21 Jul 2020 14:04:46 +0800
From: Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 0/2] Modularization of DFL private feature drivers
Message-ID: <20200721060446.GC17091@yilunxu-OptiPlex-7050>
References: <1594791498-14495-1-git-send-email-yilun.xu@intel.com>
 <0c7c63b8-5444-2deb-9fed-18956a5ad938@redhat.com>
 <DM6PR11MB38194C448ECCF1E6BF386D3F857C0@DM6PR11MB3819.namprd11.prod.outlook.com>
 <237c776b-8746-421d-26ad-eea7242a9172@redhat.com>
 <DM6PR11MB3819828C1C193087AC6A4629857B0@DM6PR11MB3819.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3819828C1C193087AC6A4629857B0@DM6PR11MB3819.namprd11.prod.outlook.com>
Sender: linux-fpga-owner@vger.kernel.org
List-Id: linux-fpga@vger.kernel.org
To: "Wu, Hao" <hao.wu@intel.com>
Cc: Tom Rix <trix@redhat.com>, "mdf@kernel.org" <mdf@kernel.org>, "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lgoncalv@redhat.com" <lgoncalv@redhat.com>, Matthew Gerlach <matthew.gerlach@linux.intel.com>

On Mon, Jul 20, 2020 at 05:21:43PM +0800, Wu, Hao wrote:
> > On 7/16/20 8:48 PM, Wu, Hao wrote:
> > >> Subject: Re: [PATCH 0/2] Modularization of DFL private feature drivers
> > >>
> > >> Generally i think this is a good approach.
> > >>
> > >> However I do have concern.
> > >>
> > >> The feature_id in dfl is magic number, similar to pci id but without a
> > vendor
> > >> id.
> > >>
> > >> Is it possible to add something like a vendor id so different vendors would
> > >> not have to be so careful to use a unique id ?
> > > Hi Tom,
> > >
> > > Thanks for the comments.
> > >
> > > Here is only one field defined in spec, that is feature id to distinguish one
> > > feature with another one. There is no vendor id here I think, and several
> > > cards are using this for now and seems not possible to change DFH format
> > > for these products. : (
> >
> > There looks like some unused bits in the first word, how about
> >
> > #define DFH_EOL            BIT_ULL(40)        /* End of list */
> >
> > +define DFH_VENDOR    GENMAKE_ULL(49,41) /* Vendor ID */
> >
> > #define DFH_TYPE        GENMASK_ULL(63, 60)    /* Feature type */
> >
> > And Intel gets id 0.
> >
> > >
> > > I fully understand the concern is the feature id management, and potential
> > > conflicts there from different vendors. One possible method to resolve this
> > > is managing the ids in a public place (web? Or just the driver header file for
> > > feature id definition), all vendors can request some feature ids, and other
> > > people can see which feature ids have been used so that they can avoid
> > > using conflict ones with other people.
> >
> > The conflict will come in development when two vendors use the same
> > unpublished feature id.
> >
> > Also keeping the truth of id's in the kernel source isn't that great because the
> > public kernel always lags development repositories.
> 
> I fully understand your point, and it's a good idea to me, but I am not sure if
> we can update the spec for DFHv0 at this moment. Let me check with spec
> owner about this. Actually I believe we don't want to add anything in driver
> code which is not defined in the spec at all. : (
> 
> >
> > >
> > > And in the later version DFH, this feature id will be replaced with GUID
> > > I think, so it can resolve the conflict problems from different vendors?
> > > But now, we still need to handle the existing ones. : )
> >
> > This is why I proposed needing to generalize the matching.
> 
> Personally I prefer that we can have standard matching functions per DFH
> specs.
> 
> Yilun, how do you think about this?

I also prefer we don't add anything now before DFL spec is updated.

The idea of extending the DFLv0 is good, but I'm not sure if it is necessary
now. It depends on how the customer is using the card, are they
developing more FME features themselves on current cards and want to make
them public.

I think we could discuss about the strategy. And we could add another
patchset if we finally decide and update the DFLv0 spec.

Thanks
Yilun

> 
> Thanks
> Hao
> 
