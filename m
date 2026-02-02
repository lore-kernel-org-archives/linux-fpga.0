Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5B035BDBB
	for <linux-fpga@vger.kernel.org>; Mon,  2 Feb 2026 10:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770029681; cv=pass; b=GfMo+QfIpfIMAjOLKbx15nqsbTZSB37h7fIzEolt4uMH1mSuusZGjrU4x9Pdzi26YIgPVBzPRwrM76MUi7+53lxoAoCujbHFioHQ0hmqVJbMrAsbv3R5kI7aLy7eMWytMmKngqzu4EJAJNUl74FrtI50Z82oUoWuSxT7WDS/xPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770029681; c=relaxed/simple;
	bh=V9ea5khPkD/wK1PULqwvQ06ZQxDk20aa1czAnCx7YtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6OZxSiSuhBjuCx2AXsobcDgkfisd8YrvQHY1oWva63g93jKoNikKX+rhM5Gxdv2o5Eya1eqYmt61OfULehFE0igRvlD15pKXEVJz6+hKRNIL9KiHKrAO7E7Uvx250n1U0os75S2kLkrJ2gvUyxsOGZdsoMC2QwUy+wYLCfsfEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzONcRXh; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzONcRXh"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b71515d8adso4226666eec.1
        for <linux-fpga@vger.kernel.org>; Mon, 02 Feb 2026 02:54:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770029679; cv=none;
        d=google.com; s=arc-20240605;
        b=KtfQndYPYRi9qRka7tP585EMoINPIRYBJQazg61GKPYawnYpP82gZgZ056FyAs3Nkl
         8XHqkOOhIO0rOw0m/wX/gZom2Jpe0pdBo/xsw9XQfxuLV1e9bmx4AJvoGgGH+kmlwV06
         8wxjZ9pw/yxbgyjDu1ofQ1rmZNllEMg9MsZAjVtbqwtECIme/MbK2P4gTVFfJlC3S8uk
         4RevTF5tTu+PENs/cIg1die1QGoPU3PeX3ylwemr6fkGU3b9uq2XQx6rciYGj7wAo11Z
         DwJpFx92edTshq25CgDkTMR+3bVoZ2dEW8ch5VJyb970RrPPvHq8kf4Jc0I3WesInq7J
         ek1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zjhNpMyF2yQrRwpFzXjP2mLxrAYnPxbG2zg/htKD0uY=;
        fh=358VWPEKg92SM0jsSe/vihAnDkNgCdKhS9EKHmrtVX8=;
        b=b8ri6JH9SgnDh7Z/iEXd0LAKYCSRo1DSzV+1oUHmsthSBZdysAcm4fMO0SuyH1/MLv
         VlX74vdEoj25W6pNVXcM5pdcSG2SYPOcmjTWB5DYAvA3dcBb1Xo11k2VK8iBUuKP99b8
         eQrCW7ScTA2NCjx7KhqkSKcy9VAoQl2k7wDTK5xk2disNF0ziTGVPOmxMVQBE0q/Njjd
         a0m+cHnPgjBPDkGzm/hq1o9rFen7iAKoaEYon+57p5wBwbnJogQNSZ6DcXG1swJWycRX
         wUHmPisG2uYivLfZVgbfiYbEjte+CU+jMD+7Yl62igjrBNlZ9BgHzDVsyWZFTEIciHXn
         rbTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770029679; x=1770634479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjhNpMyF2yQrRwpFzXjP2mLxrAYnPxbG2zg/htKD0uY=;
        b=BzONcRXh99ZSqQmHgNedgd/1mqagMbFUBHxOODoQLMp0Sn6qqKp9iaxjPEgvp/IvRL
         sEREVLRc9YhZDBTo6o+Q8iviS9QkefPzbnh3RyG7bLoRO835yUz9W7ndDE8ZS/v8/mBp
         DRTnX7yZk5X0l0QjGZQJ5gXVBSj2FyI8hCxyXLP+MX45Ed4E+LviNdGf/BsOc16TqdAc
         XxuspYMt6zwYz/ZWj6HG052xdz5jGDNtU09XTaacp1G8yv15tZivbeA9Spu0M82YZFP5
         dpCOKt0CdazwwgZKbDKD46NjbdpZdJujp6tCjzPABKk2obsH+orkig6mz5IK0ZPyqtFj
         /SBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770029679; x=1770634479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zjhNpMyF2yQrRwpFzXjP2mLxrAYnPxbG2zg/htKD0uY=;
        b=Nb4n9l5Cmc3BpRdZ57ybYUHaP61rPA/Td+XlDOU+dXuycNiyauLAdYG5ZqeDhTdrXy
         RWTT4AvXPAltQ4wMaP+y7QhVH06Wcbp7tpq8ExAwDAnU0n2UheiSQ3EV2iysjehN2DGa
         s/kjQXI5jAc6gZMtnRWAy7IASgWQab1wvPquqV1+mVnRPJjJbtEBA3PjGS9sf1Uhru+T
         LZnu63V0zpQvwsFpN1c9EjTCEety2PJKfBMAE7bynlREwJ7NcAK0zF3879GypmsmUhLB
         xsxbPDzb+VP4v6cxWmcVB3fBMUU/dRIavyHf5oGFbOw/D1kudfz/glVvMqhHrP3TOdYz
         G4GA==
X-Forwarded-Encrypted: i=1; AJvYcCUZbM6hDHeksztgk72T8+ZygmhBa1mfb2XKDEVcoYMzTjdNNjvrvvTzRHaCP76mDhGetBR9cWERqwfe@vger.kernel.org
X-Gm-Message-State: AOJu0YzRaUFv2Pcfj6/TDlbq3xzw8sX6digRF/TnQf+gOFebxEScjoB5
	D9LGM/KSqSLM34sDVggXm/T2+vPvG3B2ul0zM9WhlgiBE63D2y/+93+r0e5CJ5h+P45LrpiI57P
	R9knj6tXuqOqIRQCpsi9BFf57FmsLyoc=
X-Gm-Gg: AZuq6aJ3Lvc74/FNBiA5wYV1nthmx/fDYqZCI8UvxmkWHgezUGIknSmwO84Hin7SK7g
	uP3LNfXXbAIFVh2CqANvBhfLkL9VRTRhdTYOGXz6NeI9Yc0CK9CZ/1gBy7t/en+fyVfkK8vUmbB
	PwgbaxgWSr98FeDXbVxWUwCue15zJ3ll/D0oTh+Xq3u/wzgGnvFMKc+PQY210wlDKBxJMfVQ7EU
	o9e8jIkT3O2NCqgxRh7swD7D1LNiAly+Qyvukk8cR9Fo1ZBkhGbOS7Uzu/r222z0ve+1rQWQuIg
	Bl+3HCsWZeDTQIN7KfAaLIG3nw8=
X-Received: by 2002:a05:7022:6082:b0:11b:a514:b64f with SMTP id
 a92af1059eb24-125c0f997a1mr5611126c88.13.1770029679083; Mon, 02 Feb 2026
 02:54:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119184708.566461-1-iansdannapel@gmail.com>
 <20251119184708.566461-3-iansdannapel@gmail.com> <f65506e6-ac29-449e-86b3-540c23ca6119@kernel.org>
 <CAKrir7hCGEdwZihgV8-JaXq1EbzQCvpJXcG_FEmDYEoJqUpbcg@mail.gmail.com> <d05daf50-dee2-4fb9-a4b4-4ef68edfe384@kernel.org>
In-Reply-To: <d05daf50-dee2-4fb9-a4b4-4ef68edfe384@kernel.org>
From: Ian Dannapel <iansdannapel@gmail.com>
Date: Mon, 2 Feb 2026 11:54:26 +0100
X-Gm-Features: AZwV_QjWp0uQXY5D9fomTO9vWVvkAlRB7KVTtr4IAVUNKFCFSTL0scOfs-nwjWc
Message-ID: <CAKrir7gueh=meE1JC0FuV+SzkkJK1+oEBVShuzoApnSWb_z1_w@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] dt-bindings: fpga: Add Efinix SPI programming bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-fpga@vger.kernel.org, mdf@kernel.org, yilun.xu@intel.com, 
	trix@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	heiko@sntech.de, neil.armstrong@linaro.org, mani@kernel.org, 
	kever.yang@rock-chips.com, dev@kael-k.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Thu, Nov 20, 2025 at 5:42=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 20/11/2025 16:55, Ian Dannapel wrote:
> > Hello Krzysztof,
> >
> > On Thu, Nov 20, 2025 at 3:13=E2=80=AFPM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >>> +properties:
> >>> +  compatible:
> >>> +    enum:
> >>> +      - efinix,trion-spi
> >>> +      - efinix,titanium-spi
> >>> +      - efinix,topaz-spi
> >>
> >>
> >> Nothing improved. You received comments about this - twice or more eve=
n
> >> - so I feel like you just don't care about review.
> > Sorry I am lost here, this is based on a similar driver, but it is
> > probably very outdated.
> > So the fallback pattern would be okay? Eg:
> > items:
> >       - enum:
> >           - efinix,trion-config
> >           - efinix,titanium-config
> >           - efinix,topaz-config
> >       - const: efinix,fpga-config
> > Or would a single compatible be better since currently from the
> > drivers perspective there is
> > no difference in hardware?
>
> Almost, because I think you asked about this and I instead asked to use
> one specific device as the fallback. Choose the oldest device and use it
> the fallback for two others. There is plenty of examples - including
> example-schema - using it with oneOf syntax.
>
> Best regards,
> Krzysztof

Just making sure before sending a new version. Like this?
compatible:
  oneOf:
    - items:
        - enum:
            - efinix,titanium-config
            - efinix,topaz-config
        - const: efinix,trion-config
    - const: efinix,trion-config

Regards,
Ian
