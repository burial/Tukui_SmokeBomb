local T, C, L = unpack(Tukui)

local mod = CreateFrame('frame', 'TukuiSmokeBomb', UIParent)
mod:SetScript('OnEvent', function(self, event, ...) return self[event](self, ...) end)
mod:RegisterEvent('ADDON_LOADED')

function mod:ADDON_LOADED(addon)
  if addon == 'TukuiSmokeBomb' then
    self:UnregisterEvent('ADDON_LOADED')
    
    self:Hide()
    self:SetPoint('CENTER', UIParent, 'CENTER', 0, -250)
    self:SetWidth(64)
    self:SetHeight(64)

    self.cooldown = CreateFrame('cooldown', nil, self)
    self.cooldown:SetPoint('TOPLEFT', self, 'TOPLEFT', 2, -2)
    self.cooldown:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', -2, 2)
    self.cooldown:SetReverse(true)
    self.cooldown.noCooldownCount = true
    self.cooldown.noOCC = true

    self.texture = self:CreateTexture(nil, 'ARTWORK')
    self.texture:SetTexCoord(.1, .9, .1, .9)
    self.texture:SetPoint('TOPLEFT', self, 'TOPLEFT', 2, -2)
    self.texture:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', -2, 2)
    self.texture:SetTexture(select(3, GetSpellInfo(76577)))

    self:SetTemplate()
    self:CreateShadow()

    self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED')

    return true
  end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(unit, spell)
  if spell == 'Smoke Bomb' and unit == 'player' or unit:sub(0, 5) == 'party' then
    self.cooldown:SetCooldown(GetTime(), 6)
    UIFrameFlash(self, 0.15, 0.15, 6, false, 0.7, 0)
    return true
  end
end
