Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75175402B8A
	for <linux-fpga@vger.kernel.org>; Thu, 28 May 2026 19:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779997471; cv=pass; b=lRIfzVTmzQgCs/mzveCmI1RDYkFE2oDAyAlzMR96S3RuYo6OM2i3TloeBVrbQP4/bEOJ8Sl7cnrl5r/W9kzV+OpSU9+3glebEGi/r5GsbdtYen2/QNIm4L/0xj9fdnow5U62vYZmvNplAHxGB7pFKcipVYuiEsq+YWwRMNr/9s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779997471; c=relaxed/simple;
	bh=PggOqUDZGTqaCUwLJ5yG3wgs9SWaOxkXoLqlLnJNbms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cl5bYvoXW5TFieToQaCgs7OEwcWslf/r3+krXt4TQMuHr5JLqXe2CHp4FY8fXXUodBGuelsCNlGjjtk1H+x33P4YZm42AgsZGi2sxlLwFTlYHE4vA+ua8GMEyNQURQFvTIMEbyzY2youMxiDLaOgbFPbStp+LAN8u1IGNIhdV1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uvCJ/t1H; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uvCJ/t1H"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so505ad.0
        for <linux-fpga@vger.kernel.org>; Thu, 28 May 2026 12:44:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779997468; cv=none;
        d=google.com; s=arc-20240605;
        b=NCQ6o23YNyTQhBOw8TwuYSOPS5q3goHy7Uo8Ssh0Nlt3/0N7ANdQCdJXGyik8z1RrJ
         hnTmppVxYe7z7N2DprcwmTaqo1XWVPwXcTuxfQs2ru3j2PhlwNgNLX6nSQgoXYbk2Jo2
         TWEApm1XCd+memOSahIG7BdhY/8b1CsN5nlLJdDDyk4pwCEu7dK4XTYm3H0Adw2WUsHk
         o1dMBlI3R3NgKtgyZtH/26Qkplv9UE/eFJgU1RytqY616sRk6v8M2AUPIsk6cqeiC/LX
         VftK13vMVuqBw9Kq0h8p4HNmxENaTbZ17Jwv4Ss9kbg5KJ+3XDYHmuWSSXJADHBZDmg4
         TOlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8IynHu/DX5NF0G96SeXwK1qnUut5hZzt9g6fKpDU65E=;
        fh=Z5DbiP/mPj9xdAW5s9+UYxiwQH1ylzGX7pi0W9F536A=;
        b=EmVCMCeNSVAKDaoihzoyYaVwtroXI2AF7NQQvbvSWnZSh+9bPl/o8wCSbqdxh+xTHX
         DV4S4P2sIFhfWzbQckcoK9z4i3GBu9lZGajStWbsuzADwnAbeFJsjoL23XNHYb9dpTwJ
         b38fsJ8+F9pqrLDNTUf26BuswO1yl39EmW7V2BOAkZ23iv6w5iMvb3dYgvUQijvQpMdu
         U/D1mJMzOryurA+d3UDLEN77TLIIifQw2gu1Eel+N6X6vGKYjy5QqHfNvtSo+bAmnARz
         cORHY0m7SriN0oP6tOe/x+/yE/KZsG1z7999DkksGepgCpR65jqflY6oRL4Tz7oyD+5c
         qbXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779997468; x=1780602268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IynHu/DX5NF0G96SeXwK1qnUut5hZzt9g6fKpDU65E=;
        b=uvCJ/t1H22WyQZ8fz8Dvq5GmEF/p4jFDadf3+BLB365SlNIpgIuYpLQ5CB3uchjMMl
         EGicwWAdpP+rJLXx7MkpVq3GDmicrjffgSVUPYE8Pt/sfRLXND1UkSvWQna3GZTKr985
         Ee9+zFmkYOvvrIZrROg+wuaNpXvQtpLVccOHigTw1DAo7JKiRFhZYJ/+M84RXlQz4UMm
         XBw4V47cCV1gtd2KyNv5fsLD+pf0t9330dOpL0VqfSWncyJVSNFW+WLB3tn9kz2sIihd
         cA/931t9gfzAeWiCm3d73DHGG7Off1xUrQM7QmPlaTAuKLKz6glSOsNOmDgDzQV3mvB+
         dbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779997468; x=1780602268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8IynHu/DX5NF0G96SeXwK1qnUut5hZzt9g6fKpDU65E=;
        b=hpk3G2e63VkZFaognimA2cogBiUJaA7lxKVOUAmnLcuwgXSvb+MgreMbLulfbdjbwM
         yhKVf5yFBTsy9tZkXEGlMVB5Jrnba1jITPPw6Fpk1567zNcC/+fW8ZArvWw95REW5Ww4
         F2x2y/fOts9JTqBkiSGz2EbzZcvtxZZI+Lc62p8bSKTQ/K8KFcPW6an1GE+ysEVb9bD8
         mFbaqT0eLUuBgv+2Pkdb5GH/klWf1lBUNwbX0NsiM7aD779ud6igk+LKXjQgI42Z5hkF
         cX+aIj3+l3WBRM/SfFKjB91Mpg7FnDmK1y4ngk+mqdj6EuIU1ZHCngL6Hl/sUqXO4yqT
         Ot0w==
X-Forwarded-Encrypted: i=1; AFNElJ+TD+Vra8X0JlOULJAna0x/KqIm/Nic5oWrfg6VRs3Q83OW8BBYQmfpBuITibUDEU8CAFVwsoFQ4cvq@vger.kernel.org
X-Gm-Message-State: AOJu0YzTA40/ucTrd+fRY9UVHZQ2D1Ry9hLgykVKiztj5Kb9gQng7VZX
	Ba58pZl3HKVHQ9fuFOjJKHHUUEO85tAfsoTU3SFTRfYZn8SofFR9r0wv7a1wdRmBCsX5rAjVghN
	mHubD14X6aApobbXYUym2pdxZCLuaTJXHmLDesUXD
X-Gm-Gg: Acq92OEi2xeIVRj921h//sON0sQZicIA4ZER+XL2vZSfLkgg25P0q9SkqsuhA9wuLs0
	sQgzQMzfveTuVKwaaWDXUWdBXnGR0iquo8ZTehuuxeiGIhxjz5PLEcjEcNMCbW5rC0ZWQ8lJ9Ee
	i1X5enh+COkzciNPG/myGoueJYTi1/YoMMr8qMQtQoKD+MB0EmyVMMSzD5IXxCUnVqTUoZdhpax
	TMZqGl3lanQZHSZEH2WeTpb1j33rHukPM08tq84vfrRVV5WuCwR5d+Nx20iWXMA0m32coJaTQbq
	CleFkCqVAu/B61UtN9c=
X-Received: by 2002:a17:902:f64b:b0:2bd:3bfd:74f1 with SMTP id
 d9443c01a7336-2bf1fb9d40amr92235ad.2.1779997467341; Thu, 28 May 2026 12:44:27
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528183625.870813-1-ynorov@nvidia.com> <20260528121806.2b54606ba6e42f7f371d95c3@linux-foundation.org>
 <ahiW5LKLiPMC6il_@yury> <20260528122903.cf74cf905418ab2d144607c3@linux-foundation.org>
 <ahiYUr0dO_dhOHTU@yury>
In-Reply-To: <ahiYUr0dO_dhOHTU@yury>
From: Ian Rogers <irogers@google.com>
Date: Thu, 28 May 2026 12:44:15 -0700
X-Gm-Features: AVHnY4KU3_bl6PIogc_loULa1uZ5IugP9iETmiYVnKICvK-frgUxDB4nRARXI20
Message-ID: <CAP-5=fXXg+PqH7EZ8X599CKYFWCwQgyH2H-4-+5M3_b9w_dTNw@mail.gmail.com>
Subject: Re: [PATCH 00/16] lib/cpumask: get rid of cpumap_print_to_pagebuf()
To: Yury Norov <ynorov@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Heiko Stuebner <heiko@sntech.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	Moritz Fischer <mdf@kernel.org>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jic23@kernel.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Dan Williams <djbw@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Will Deacon <will@kernel.org>, 
	Jiucheng Xu <jiucheng.xu@amlogic.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Linu Cherian <lcherian@marvell.com>, Gowthami Thiagarajan <gthiagarajan@marvell.com>, 
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>, Khuong Dinh <khuong@os.amperecomputing.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Aboorva Devarajan <aboorvad@linux.ibm.com>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Besar Wicaksono <bwicaksono@nvidia.com>, 
	Ma Ke <make24@iscas.ac.cn>, Chengwen Feng <fengchengwen@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-perf-users@vger.kernel.org, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-fpga@vger.kernel.org, 
	linux-rdma@vger.kernel.org, nvdimm@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-cxl@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 12:32=E2=80=AFPM Yury Norov <ynorov@nvidia.com> wro=
te:
>
> On Thu, May 28, 2026 at 12:29:03PM -0700, Andrew Morton wrote:
> > On Thu, 28 May 2026 15:26:28 -0400 Yury Norov <ynorov@nvidia.com> wrote=
:
> >
> > > On Thu, May 28, 2026 at 12:18:06PM -0700, Andrew Morton wrote:
> > > > On Thu, 28 May 2026 14:36:07 -0400 Yury Norov <ynorov@nvidia.com> w=
rote:
> > > >
> > > > > cpumap_print_to_pagebuf() is the equivalent for the "&*pb[l]" not=
ation
> > > > > in printk-like functions. In some cases, it makes people to creat=
e
> > > > > temporary buffers for the printed cpumasks, where it can be avoid=
ed.
> > > > >
> > > > > Get rid of it in a favor of more standard printing API.
> > > > >
> > > > > Each patch, except for the last one, is independent and may be mo=
ved with
> > > > > the corresponding subsystem. Or I can take it in bitmap-for-next,=
 at
> > > > > maintainers' discretion.
> > > > >
> > > > > On top of bitmap-for-next.
> > > >
> > > > Sashiko doesn't attempt bitmap-for-next, so it couldn't apply this =
series.
> > > >   https://sashiko.dev/#/patchset/20260528183625.870813-1-ynorov@nvi=
dia.com
> > >
> > > OK... What should I do about that?
> >
> > Rebase onto something which Sashiko *does* attempt.  Mainline, a few
> > mm.git branches.  Maybe linux-next.
>
> Is Sashiko a new mandatory requirement now? Documentation doesn't even
> mention the bot.
>
> > Roman, is there a list of trees/branches which Sashiko tries to apply
> > series to?
>
> Hi Roman,
>
> Can you add bitmap-for-next in the list?

Fwiw, you can see the list of branches attempted and the SHA they are
at in the Baseline drop down:

Baseline Status Log
tip/x86/core (0f61b1860cc3f52aef9036d7235ed1f017632193) Failed View Log
powerpc/HEAD (6916d5703ddf9a38f1f6c2cc793381a24ee914c6) Failed View Log
chanwoo/HEAD (7fd2df204f342fc17d1a0bfcd474b24232fb0f32) Failed View Log
linux-arm/HEAD (dd6c438c3e64a5ff0b5d7e78f7f9be547803ef1b) Failed View Log
linux-pm/HEAD (e7ae89a0c97ce2b68b0983cd01eda67cf373517d) Failed View Log
linux-fpga/HEAD Failed View Log
pci/HEAD (254f49634ee16a731174d2ae34bc50bd5f45e731) Failed View Log
linux-pm/thermal (21c315342b81526874acfa311f11b3f72bed4e14) Failed View Log
rdma/HEAD (67464f388d52ec172be62c99fc43697437ffa384) Failed View Log
linux-next/HEAD (f7af91adc230aa99e23330ecf85bc9badd9780ad) Failed View Log
HEAD (917719c412c48687d4a176965d1fa35320ec457c) Failed View Log

Thanks,
Ian
