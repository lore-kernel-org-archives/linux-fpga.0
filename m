Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8815832BF4B
	for <linux-fpga@vger.kernel.org>; Thu, 20 Nov 2025 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654133; cv=none; b=Xks7lUh1WfykXJl4STXf/fa+KgqVih7RW9jtqG2WRvLlt+QrMunolbNG8v5GAWufuVJW0d0gcTVHAfjD4YBjHbb9IMf+NO66vwWLyP/3XwjGA1lEA0NQ0dDplM0uSeXzq0u5MS1OhBREhHne4eDOqMiPgv2AClPDlZBbA5WdGak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654133; c=relaxed/simple;
	bh=KpwVOmFqTFuo0Z6eKiC5OzlZRDQzEkNyBAiLc6W/jgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=huwyT9vXlS/cWGZCMf6s7qQA6GD8YPUJPV2mRzxn9eDNXPp+TMme0ZM1dW85cNAwQuKcdRqMvLTqM4U/aisASKcZtNAjWpbz3Q/OJEVSk5F9S5ZsJ7wHf8nW1acfZDGPQPb7+WyDw5lZticQFIG/hD4ZLflqA48nU5gsCYPPMfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ane5loVE; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ane5loVE"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7633027cb2so203287766b.1
        for <linux-fpga@vger.kernel.org>; Thu, 20 Nov 2025 07:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763654130; x=1764258930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghmWOWbZTvWynBucWAPubJECyzCUtCvAL03C9/TJgWg=;
        b=Ane5loVEgyI1S9DAhW0w48sONc18cjnZwF6uXBslI1P6YIEdRhK+1ymX61z1MyESiN
         Iz4ifBKIJy1IXKu26sX3vdBikRNPzH4e2y8jYoWvheR14Wtk1mEaAhvpgmEroIG+MSM/
         Q2zB23YYQeHNOzKZoAiii9tleKT9ucXEcVZpavGy0dR7prM24Tdq57Aw5Kz6jCsM4wSm
         dVIymUQzjrILr550Q+H7geGB0NN/6obgQ153LFUUyhHJpeeGI4yYsEYqfDweOE7BgyVD
         g/B3LEFDfmmYTmkJAN2ViCHF4arZE8rqgFJiRwtvkDD3qnuOceofIFEfM86AxbbLmXsj
         XmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763654130; x=1764258930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ghmWOWbZTvWynBucWAPubJECyzCUtCvAL03C9/TJgWg=;
        b=ash71MlbGSHHogSrPEf1F9hUxzJhw9kYP1vGTy/vBpkCJgqFT+WsmDnbfAUhnIBfsc
         9ojZTN86dDwrvhN7nm+JH97zpeJr7faSinkRRv5QDErLy5Dc/VtE20F1hxBGHIWbrwmW
         SS3LtJdLTDhkG+ah37MVCQlKUpdUuY7TiKPA892d+oxq0aM4ddbcsOhmhq76piYtFmOM
         qDDyp8T66BLSoESOX8PlAjU7i+JRT4t+p14+xnex0utOTkhKugkFg52GbvJqPWx8LbKD
         SgkRwwrWMuLzJhooLPP1tAyQIEDDm//JkfvHG5AgYkU9paRKHSjCaAnqbhjiPEWxf+Qd
         kyZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp94pUJ7fAdFJqgxHjvccJrqkYE+TNB3Wy3xwU06Qn1BxsZtSSVSSyTPqIscVgh7aFU9N2tvbgJeuD@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdf3wH/e8s46lKbYDDuEutKTfUzZZZ7dOMOW1NNbUlRpRHfL93
	Ia+L/NOm6W5QC4Y51t1CAz17pAjC1KI/+WhP9xAUZwm46Fg6NqO56HM1prj7SWi/7RU9rQy1T2E
	Q38bCb3pGjuN7HBPNOdHdZjCDdstrCt4=
X-Gm-Gg: ASbGnctEulxg88qQot+i6jXJnw3505ADRmgxPjaBroD9RAn8MTmttipNWT42+zbPjCn
	8eRtKohlDJEqHfWg1/3G2K9yCjTcOpp2SBdWB6T/DKD9Mt2gvhPSys2qvHov7gWN8OIVYGe402N
	8aH5Olf9IBrOfiQk92aKbFni5U47EDpDp67SfF3ncT2mhebsbO8D7WtU8mxPHPQrQ2f/XqVGmz2
	9JtSQP43W+LEpKX1m18b4Ld4t68GMkv5OLEgXA2Er0ADAUBJnYtqxQOeHyOj+S0aizLbPYe
X-Google-Smtp-Source: AGHT+IE0AL5MA9t89Ar84y72vT9ZL5wd2+e4neIMpRgtPuskz8HYSHudABZkUsiN9omSjTRJqVFxwNJKwVHrMsWiKdo=
X-Received: by 2002:a17:907:1c1a:b0:b75:721:4297 with SMTP id
 a640c23a62f3a-b765560c0d0mr352163266b.47.1763654129618; Thu, 20 Nov 2025
 07:55:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119184708.566461-1-iansdannapel@gmail.com>
 <20251119184708.566461-3-iansdannapel@gmail.com> <f65506e6-ac29-449e-86b3-540c23ca6119@kernel.org>
In-Reply-To: <f65506e6-ac29-449e-86b3-540c23ca6119@kernel.org>
From: Ian Dannapel <iansdannapel@gmail.com>
Date: Thu, 20 Nov 2025 16:55:18 +0100
X-Gm-Features: AWmQ_bkzVO_sfFN_FTjyX56BaPglZeVMgyhMY0yBpAno-4oPfspKiU2yA45zqiQ
Message-ID: <CAKrir7hCGEdwZihgV8-JaXq1EbzQCvpJXcG_FEmDYEoJqUpbcg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] dt-bindings: fpga: Add Efinix SPI programming bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-fpga@vger.kernel.org, mdf@kernel.org, yilun.xu@intel.com, 
	trix@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	heiko@sntech.de, neil.armstrong@linaro.org, mani@kernel.org, 
	kever.yang@rock-chips.com, dev@kael-k.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Krzysztof,

On Thu, Nov 20, 2025 at 3:13=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - efinix,trion-spi
> > +      - efinix,titanium-spi
> > +      - efinix,topaz-spi
>
>
> Nothing improved. You received comments about this - twice or more even
> - so I feel like you just don't care about review.
Sorry I am lost here, this is based on a similar driver, but it is
probably very outdated.
So the fallback pattern would be okay? Eg:
items:
      - enum:
          - efinix,trion-config
          - efinix,titanium-config
          - efinix,topaz-config
      - const: efinix,fpga-config
Or would a single compatible be better since currently from the
drivers perspective there is
no difference in hardware?
> NAK
>
> Best regards,
> Krzysztof
Thanks for review
Best regards,
Ian
