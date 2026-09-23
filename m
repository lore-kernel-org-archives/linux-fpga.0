Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DAD560ADD
	for <linux-fpga@vger.kernel.org>; Wed, 23 Sep 2026 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182676; cv=none; b=AilPTcoqYhWywNnJsXmKrd0QblKWn0z7VtKSEYE2mrfR++0NrOuBwp6ilNHndw+ptjNtzc5uW7fPzJn//TxP+h3M3RZMUjKW43QNKLq1MGvWosSH+1/K8IS8EXUW1dGb6cy9r0VWIHyZXtcTtkd8wg6gXXlg307TiXQakVtXpjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182676; c=relaxed/simple;
	bh=JuSfee3spNjraPLoJJYKGKhd5S4RNRzYNa4F6WmuiOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTXmypKmWSggfoTwzVOxn702lxlj6itLUScEayJkZ3Q5fCm4XL6YpBIQ7qPvTadLDlpe2C7VF00Hs8qS0WFgEssz9Wtb7ZLx++2CW4ryAFFQmKxOrEtuguEkWhiiZwN7iOneY9uBS6t4fD0AafuknIn6i4fltzMlRTpHM2Ut8vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYSlQJDt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYSlQJDt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E521F008A1
	for <linux-fpga@vger.kernel.org>; Wed, 23 Sep 2026 16:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790182674;
	bh=NqzOEhCpUsv7AnQHqiZ+M2etm1gpTR5dRdhOo+HPW8k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BYSlQJDt4429uNa62Mmi2vGf1ktQovu4F6jsYdMyDxTp/0HwHXh07nmyUaCRfqWFQ
	 2Rlqtj0t9y1xQtxHLdNu57VHK1qsbfdJ9hepjXe49YYPiVG/mq6SzLluEHVL2RuWm6
	 ErIcBr5d29fHIAk8iF31kHPtLDPcXzFr2v/sQeacj2FCNSg5a7UpcwVED5HSybkRGW
	 CHL7YGOjShEgridonCrC9qg/4rINZAtmUGTWBGI3G2tTgTy9giZKxjQaATIRaiZEOY
	 udwIMPD4YGJjKmlZXtI52JpP1mEvWdYqcR5F4JT4PXIIj/0imnIcH6LYJ7D/JhKN4Q
	 tQWI339W1YTaw==
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6a99c5de614so1647497a12.2
        for <linux-fpga@vger.kernel.org>; Wed, 23 Sep 2026 09:57:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBznqTZs62bOq/HMPl16ExhMsLeyHTagqzEUkWrkvYjFbrarX7jmv9NrpZj0oJew+3UGgr4TZ0Hzi7YU@vger.kernel.org
X-Gm-Message-State: AFuF++m4OWvGMQgwdNqysXrBztNoE51YwhDeBEBFNiWaxgf6oPsSKer8
	czH9lW5+1BZkrqBkC5zhnWeRag9SxpoG/4lBLODOdsP5cg6DQ19KONt3xhhkR6qO8egGnatqAdm
	G7eI58u+20q+YYAHdolwO3WWjBJ1Krw==
X-Received: by 2002:a05:6402:2410:b0:6aa:734b:1a26 with SMTP id
 4fb4d7f45d1cf-6aab3b6d209mr2948355a12.32.1790182673003; Wed, 23 Sep 2026
 09:57:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <417b510f-0f6d-4695-97f5-3fc19b9377b9@linux.dev>
 <amCn8UYdybT+RRnq@yilunxu-OptiPlex-7050> <9d4af487-69a7-4a0d-9335-35c3a057de54@linux.dev>
 <anBfAa4LpjbmYHIc@yilunxu-OptiPlex-7050> <db7cfe9e-b2ba-4323-bff9-44598e1f70bb@linux.dev>
 <anl8891cH+bUfsGY@yilunxu-OptiPlex-7050> <4dbdb52e-1b28-432e-a3a7-ad9c44f17d27@linux.dev>
 <aoJ6paA/8ndpJ17y@yilunxu-OptiPlex-7050> <8848432d-45b0-4efe-adf3-adfb64fe0899@linux.dev>
 <11b1a792-f8b1-4fce-8a7a-8352149febcf@linux.dev> <aq12s+hUVnnvCKmZ@yilunxu-OptiPlex-7050>
 <2adefc6f-328c-4683-8cba-091d9f3425ab@linux.dev> <1857df9a-8952-426e-988b-cd05d45a04cc@kernel.org>
 <12839ca0-cb1d-41da-9e48-bbec59ebf230@linux.dev>
In-Reply-To: <12839ca0-cb1d-41da-9e48-bbec59ebf230@linux.dev>
From: Rob Herring <robh@kernel.org>
Date: Wed, 23 Sep 2026 11:57:41 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+XUzJaEY6euyZjqhnwhu1U1u7owU40BKnvadueArwmkA@mail.gmail.com>
X-Gm-Features: AclHuK_HDp1BguoYtFD8euZtFmV2810PalDI9eSaa-agqpv3iH7aaaRilW_DBz0
Message-ID: <CAL_Jsq+XUzJaEY6euyZjqhnwhu1U1u7owU40BKnvadueArwmkA@mail.gmail.com>
Subject: Re: [RFC PATCH] fpga: region: Add support for FPGA region variants
To: Marco Pagani <marco.pagani@linux.dev>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Saravana Kannan <saravanak@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 11:43=E2=80=AFAM Marco Pagani <marco.pagani@linux.d=
ev> wrote:
>
>
>
> On 23/09/2026 17:09, Krzysztof Kozlowski wrote:
> > On 23/09/2026 16:30, Marco Pagani wrote:
> >>
> >>
> >> On 18/09/2026 19:36, Xu Yilun wrote:
> >>> On Fri, Sep 18, 2026 at 05:07:07PM +0200, Marco Pagani wrote:
> >>>>
> >>>> Hi Yilun,
> >>>>
> >>>> Is it okay with you if I CC the DT people to ask for an opinion?
> >>>
> >>> Of course. It's good to know in which case could a DTO be applied.
> >>>
> >>> But to be clear, I think that only affects how we accept and apply th=
e
> >>> image-DTO pair. For now, I basically don't want a varient selection
> >>> interface.
> >>
> >>
> >> Hello Rob, Saravana, Krzysztof, Conor,
> >>
> >> I'm CC-ing you on this thread as OF/DT maintainers to kindly ask
> >> for your input on this debate we are having about how to implement
> >> userspace FPGA reconfiguration, an important feature currently
> >> lacking in mainline kernel.
> >>
> >> https://lore.kernel.org/all/20260608164247.1998417-1-marco.pagani@linu=
x.dev
> >>
> >> To recap: modern FPGAs allow portions of the fabric to be reconfigured
> >> at runtime to dynamically swap soft IPs. Usually, these IPs are
> >> connected through a non-discoverable on-chip bus like AMBA AXI.
> >> From a kernel perspective, this means the FPGA device configuration
> >> image (bitstream) must be paired with a DT fragment that describes
> >> the new topology.
> >>
> >> In this thread, we are essentially debating between two approaches for
> >> implementing FPGA userspace reconfiguration at runtime:
> >>
> >> - Statically defined Variants (this RFC): Userspace can change FPGA
> >>   configuration by selecting from a pre-validated set of variants
> >>   (DT fragments) baked into the base DT.
> >
> > I don't know what DT fragments are, maybe you meant overlays? But they
> > are not baked into the base DT.
> >
> > There are no bindings here and no DT maintainers were CCed on this RFC,
> > so I really do not get how this patch can enable something like that.
> >
> > Linked URL shows some undocumented ABI, so obviously this would be a no
> > go. And RFC prefix does not justify undocumented ABI. At least one
> > without clear explanation in the cover letter, why is this RFC and why
> > it cannot be merged/reviewed.
>
> Sorry, I couldn't have imagined that missing ABI documentation in a
> "proof of concept" RFC would be so detrimental while asking for a
> high-level opinion.

I think the point is the RFC needs to say why it can't be merged.
Otherwise we have to guess no documentation is because you don't know
that's a requirement or because it is an RFC.

> >> - Runtime DTOs (Nava's RFC): Userspace can change FPGA configuration
> >>   by loading DTOs that are validated at runtime.
> >
> > If runtime overlays were working, this looks suitable to the problem of
> > runtime change of the hardware. This also fits hot-pluggable hardware
> > problem, which Bootlin is working on.

Overlays were the plan when FPGA regions were added to the kernel. Not
sure why that never happened. I would suggest you go read any
discussions from that.

> Glad to know the problem is already being solved.

Not sure I'd go that far. There are plenty of areas that need
help/attention. And I don't like merging new things with only one user
because every time I do that, someone comes along right after wanting
something a bit different...

Rob
